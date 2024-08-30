<template>
    <AppLayout title="Crop Management">
        <template #page-title>
            Crop Management
        </template>

        <template #content>
            <div class="row g-4 mb-5">
                <div class="col-md-6 col-xxl-3">
                    <div
                        class="card card-body bg-primary bg-opacity-10 border border-primary border-opacity-25 p-4 h-100">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h4 class="mb-0">{{ totalCrops }}</h4>
                                <span class="h6 fw-light mb-0">Total Crops</span>
                            </div>
                            <div class="icon-lg rounded-circle bg-primary text-white mb-0">
                                <i class="fa-solid fa-Seedling fa-fw"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 col-xxl-3">
                    <div
                        class="card card-body bg-success bg-opacity-10 border border-success border-opacity-25 p-4 h-100">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h4 class="mb-0">{{ inGrowth }}</h4>
                                <span class="h6 fw-light mb-0">In Growth</span>
                            </div>
                            <div class="icon-lg rounded-circle bg-success text-white mb-0">
                                <i class="fa-solid fa-leaf fa-fw"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 col-xxl-3">
                    <div
                        class="card card-body bg-warning bg-opacity-10 border border-warning border-opacity-25 p-4 h-100">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h4 class="mb-0">{{ readyToHarvest }}</h4>
                                <span class="h6 fw-light mb-0">Cycles Completed</span>
                            </div>
                            <div class="icon-lg rounded-circle bg-warning text-dark mb-0">
                                <i class="fa-solid fa-calendar-check fa-fw"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 col-xxl-3">
                    <div class="card card-body bg-info bg-opacity-10 border border-info border-opacity-25 p-4 h-100">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h4 class="mb-0">5</h4>
                                <span class="h6 fw-light mb-0">Growth Progression</span>
                            </div>
                            <div class="icon-lg rounded-circle bg-info text-white mb-0">
                                <i class="fa-solid fa-chart-line fa-fw"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row g-4 mb-5">
                <div class="col-md-6">
                    <div class="card card-body">
                        <h5 class="card-title">Growth Progression</h5>
                        <canvas id="growthStagesChart"></canvas>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card card-body">
                        <h5 class="card-title">Growth Trends</h5>
                        <canvas id="growthTrendsChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="d-flex mb-4">
                <div class="flex-grow-1">
                    <input v-model="searchQuery" type="search" class="form-control" placeholder="Search crops..."
                        aria-label="Search">
                </div>
                <button class="btn btn-primary ms-3" @click="scrollToAddCrop">
                    Add Crop
                </button>

            </div>

            <div class="card mt-4">
                <div class="card-body">
                    <h5 class="card-title">Detailed Crop List</h5>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead>
                                <tr>
                                    <th :class="TableHasText" style="width: 15%">Crop</th>
                                    <th :class="TableHasText" style="width: 15%">Growth Stage</th>
                                    <th :class="TableHasText" style="width: 15%">Planting Date</th>
                                    <th :class="TableHasText" style="width: 15%">Harvest Date</th>
                                    <th :class="TableHasText" style="width: 20%">Cycle Progress</th>
                                    <th :class="TableHasText" style="width: 20%" class="text-center">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="crop in paginatedCrops" :key="crop.id">
                                    <td :class="TableHasText">{{ crop.name }}</td>
                                    <td :class="TableHasText">{{ crop.growth_stage }}</td>
                                    <td :class="TableHasText">{{ crop.planting_date }}</td>
                                    <td :class="TableHasText">{{ crop.harvest_date }}</td>
                                    <td :class="TableHasText">
                                        <div class="progress">
                                            <div class="progress-bar" :style="{ width: crop.cycle_progress + '%' }"
                                                role="progressbar">
                                                {{ crop.cycle_progress }}%
                                            </div>
                                        </div>
                                    </td>
                                    <td :class="TableHasText" class="text-center">
                                        <button class="btn btn-primary btn-sm ms-3" @click="setNextStage(crop)">
                                            <i class="fas fa-arrow-right"></i> Next Stage
                                        </button>
                                        <button class="btn btn-info btn-sm ms-3" @click="viewNote(crop)">
                                            <i class="fas fa-sticky-note"></i> Note
                                        </button>
                                        <button class="btn btn-danger btn-sm ms-3" @click="deleteCrop(crop)">
                                            <i class="fas fa-trash-alt"></i> Delete
                                        </button>
                                    </td>

                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="pt-3 table-footer">
                        <div class="d-sm-flex justify-content-sm-between align-items-sm-center">
                            <p class="mb-sm-0 text-center text-sm-start">
                                Showing {{ startIndex + 1 }} to {{ endIndex }} of {{ filteredCrops.length }} entries
                            </p>
                            <nav class="mb-sm-0 d-flex justify-content-center" aria-label="navigation">
                                <ul class="pagination pagination-sm pagination-primary-soft mb-0">
                                    <li class="page-item" :class="{ disabled: currentPage === 1 }">
                                        <a class="page-link" @click="changePage(currentPage - 1)">Prev</a>
                                    </li>
                                    <li class="page-item" v-for="page in totalPages" :key="page"
                                        :class="{ active: currentPage === page }">
                                        <a class="page-link" @click="changePage(page)">{{ page }}</a>
                                    </li>
                                    <li class="page-item" :class="{ disabled: currentPage === totalPages }">
                                        <a class="page-link" @click="changePage(currentPage + 1)">Next</a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card mt-4" id="addcrops">
                <div class="card-body">
                    <h5 class="card-title">Growth Tracker</h5>
                    <form @submit.prevent="addGrowthEntry">
                        <div class="mb-3">
                            <label for="cropSelect" class="form-label">Crop Name</label>
                            <input v-model="newGrowthEntry.name" type="text" class="form-control" id="cropSelect"
                                required>
                        </div>
                        <div class="mb-3">
                            <label for="growthStage" class="form-label">Growth Stage</label>
                            <select v-model="newGrowthEntry.stage" class="form-select" id="growthStage" required>
                                <option value="Seedling">Seedling</option>
                                <option value="Vegetative">Vegetative</option>
                                <option value="Flowering">Flowering</option>
                                <option value="Fruiting">Fruiting</option>
                                <option value="Ripening">Ripening</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="note" class="form-label">Note</label>
                            <textarea v-model="newGrowthEntry.note" class="form-control" id="note" rows="3"
                                required></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">Add Entry</button>
                    </form>
                </div>
            </div>

            <div class="modal fade" id="viewNote" tabindex="-1" aria-labelledby="viewNoteLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="viewNoteLabel">Note</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p>{{ note }}</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>

        </template>

        <template #preloader>

        </template>
    </AppLayout>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue';
import { Chart, registerables } from 'chart.js';
import AppLayout from '@/Layouts/AppLayout.vue';
import axios from 'axios';
import Swal from 'sweetalert2';

Chart.register(...registerables);

const TableHasText = ref("text-start");
const searchQuery = ref('');
const currentPage = ref(1);
const itemsPerPage = 5;
const crops = ref([]);
const recommendations = ref([]);
const selectedCrop = ref(null);
const newGrowthEntry = ref({ stage: '', note: '' });
const addCropSectionId = 'addcrops';
const totalCrops = computed(() => crops.value.length);
const inGrowth = computed(() => crops.value.filter(crop => crop.cycle_progress < 100).length);
const readyToHarvest = computed(() => crops.value.filter(crop => crop.cycle_progress === 100).length);

const fetchData = async () => {
    try {
        const [cropsResponse, recommendationsResponse] = await Promise.all([
            axios.get('/crops'),
            axios.get('/recommendations')
        ]);
        crops.value = cropsResponse.data;
        recommendations.value = recommendationsResponse.data;
    } catch (error) {
        console.error('Error fetching data:', error);
    }
};

const viewDetails = (crop) => {
    console.log('Viewing details for crop:', crop);
};

const filteredCrops = computed(() => {
    if (!searchQuery.value) return crops.value;
    return crops.value.filter(crop =>
        crop.name.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
        crop.growth_stage.toLowerCase().includes(searchQuery.value.toLowerCase())
    );
});

const totalPages = computed(() => Math.ceil(filteredCrops.value.length / itemsPerPage));

const paginatedCrops = computed(() => {
    const start = (currentPage.value - 1) * itemsPerPage;
    const end = start + itemsPerPage;
    return filteredCrops.value.slice(start, end);
});

const startIndex = computed(() => (currentPage.value - 1) * itemsPerPage);
const endIndex = computed(() => Math.min(startIndex.value + itemsPerPage, filteredCrops.value.length));

const changePage = (page) => {
    if (page > 0 && page <= totalPages.value) {
        currentPage.value = page;
    }
};

const deleteCrop = async (crop) => {
    const result = await Swal.fire({
        title: 'Are you sure?',
        text: `Do you really want to delete ${crop.name}?`,
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, delete it!',
        cancelButtonText: 'Cancel'
    });

    if (result.isConfirmed) {
        try {
            await axios.delete(`/crops/${crop.id}`);
            await fetchData();
            Swal.fire(
                'Deleted!',
                `${crop.name} has been deleted.`,
                'success'
            );
        } catch (error) {
            console.error('Error deleting crop:', error);
            Swal.fire(
                'Error!',
                'There was an error deleting the crop.',
                'error'
            );
        }
    }
};

const scrollToAddCrop = () => {
    const section = document.getElementById(addCropSectionId);
    if (section) {
        section.scrollIntoView({ behavior: 'smooth' });
    }
};


const addGrowthEntry = async () => {
    try {
        await axios.post(`/crops/${selectedCrop.value}/growth-entries`, newGrowthEntry.value);
        await fetchData();
        newGrowthEntry.value = { stage: '', note: '' };
        selectedCrop.value = null;

        // Show success notification
        Swal.fire({
            title: 'Success!',
            text: 'Growth entry added successfully.',
            icon: 'success',
            confirmButtonText: 'OK'
        });
    } catch (error) {
        console.error('Error adding growth entry:', error);

        // Show error notification
        Swal.fire({
            title: 'Error!',
            text: 'There was an error adding the growth entry.',
            icon: 'error',
            confirmButtonText: 'OK'
        });
    }
};

const setNextStage = async (crop) => {
    const result = await Swal.fire({
        title: 'Set Next Stage',
        text: `Do you want to set the next growth stage for ${crop.name}?`,
        icon: 'question',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, proceed!',
        cancelButtonText: 'Cancel'
    });

    if (result.isConfirmed) {
        try {
            await axios.get(`/crops/${crop.id}/next-stage`);
            await fetchData();
            Swal.fire(
                'Updated!',
                `The growth stage for ${crop.name} has been updated.`,
                'success'
            );
        } catch (error) {
            console.error('Error setting next stage:', error);
            Swal.fire(
                'Error!',
                'There was an error setting the next stage.',
                'error'
            );
        }
    }
};

const createGrowthStagesChart = () => {

    const cropStages = crops.value.reduce((acc, crop) => {
        acc[crop.growth_stage] = acc[crop.growth_stage] ? acc[crop.growth_stage] + 1 : 1;
        return acc;
    }, {});

    const ctx = document.getElementById('growthStagesChart').getContext('2d');
    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: crops.value.map(crop => crop.name),
            datasets: [{
                label: 'Growth Progression',
                data: Object.values(cropStages),
                backgroundColor: 'rgba(153, 102, 255, 0.2)',
                borderColor: 'rgba(153, 102, 255, 1)',
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        stepSize: 1,
                        callback: (value) => {
                            const stages = ['Planting', 'Germination', 'Vegetative', 'Flowering', 'Maturing'];
                            return stages[value - 1] || '';
                        }
                    }
                }
            }
        }
    });
};


const createGrowthTrendsChart = () => {
    const ctx = document.getElementById('growthTrendsChart').getContext('2d');

    const colors = [
        'rgba(255, 99, 132, 0.2)',  // Red background
        'rgba(54, 162, 235, 0.2)',  // Blue background
        'rgba(255, 206, 86, 0.2)',  // Yellow background
        'rgba(75, 192, 192, 0.2)',  // Teal background
        'rgba(153, 102, 255, 0.2)', // Purple background
        'rgba(255, 159, 64, 0.2)',  // Orange background
        'rgba(99, 255, 132, 0.2)',  // Light green background
        'rgba(235, 64, 52, 0.2)'    // Coral background
    ];

    const borderColors = [
        'rgba(255, 99, 132, 1)',    // Red border
        'rgba(54, 162, 235, 1)',    // Blue border
        'rgba(255, 206, 86, 1)',    // Yellow border
        'rgba(75, 192, 192, 1)',    // Teal border
        'rgba(153, 102, 255, 1)',   // Purple border
        'rgba(255, 159, 64, 1)',    // Orange border
        'rgba(99, 255, 132, 1)',    // Light green border
        'rgba(235, 64, 52, 1)'      // Coral border
    ];

    new Chart(ctx, {
        type: 'line',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug'],
            datasets: crops.value.map((crop, index) => ({
                label: crop.name,
                data: Array.from({ length: 8 }, (_, i) => Math.random() * 100),
                backgroundColor: colors[index % colors.length],  // Assign background color
                borderColor: borderColors[index % borderColors.length],  // Assign border color
                borderWidth: 1,
                fill: true
            }))
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
};


const note = ref(null);

const viewNote = (crop) => {
    note.value = crop.growth_stage_note;
    const modal = new bootstrap.Modal(document.getElementById('viewNote'));
    modal.show();
};


onMounted(async () => {
    await fetchData();
    createGrowthStagesChart();
    createGrowthTrendsChart();
});
</script>

<style lang="scss">
.icon-lg {
    width: 48px;
    height: 48px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.5rem;
}
</style>
