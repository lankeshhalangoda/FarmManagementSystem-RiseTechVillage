<template>
    <AppLayout title="Soil Condition Monitoring">
        <template #page-title>
            Soil Condition Monitoring
        </template>

        <template #content>
            <div class="row g-4 mb-5">
                <div class="col-md-6 col-xxl-3">
                    <div
                        class="card card-body bg-primary bg-opacity-10 border border-primary border-opacity-25 p-4 h-100">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h4 class="mb-0">{{ totalSoilConditions }}</h4>
                                <span class="h6 fw-light mb-0">Total Soil Conditions</span>
                            </div>
                            <div class="icon-lg rounded-circle bg-primary text-white mb-0">
                                <i class="fa-solid fa-thermometer-half fa-fw"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 col-xxl-3">
                    <div
                        class="card card-body bg-success bg-opacity-10 border border-success border-opacity-25 p-4 h-100">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h4 class="mb-0">{{ optimalConditions }}</h4>
                                <span class="h6 fw-light mb-0">Optimal Conditions</span>
                            </div>
                            <div class="icon-lg rounded-circle bg-success text-white mb-0">
                                <i class="fa-solid fa-water fa-fw"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 col-xxl-3">
                    <div
                        class="card card-body bg-warning bg-opacity-10 border border-warning border-opacity-25 p-4 h-100">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h4 class="mb-0">{{ warningConditions }}</h4>
                                <span class="h6 fw-light mb-0">Warning Conditions</span>
                            </div>
                            <div class="icon-lg rounded-circle bg-warning text-dark mb-0">
                                <i class="fa-solid fa-exclamation-triangle fa-fw"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 col-xxl-3">
                    <div class="card card-body bg-info bg-opacity-10 border border-info border-opacity-25 p-4 h-100">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h4 class="mb-0">5</h4>
                                <span class="h6 fw-light mb-0">Soil Parameters</span>
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
                        <h5 class="card-title">Soil Parameters Distribution</h5>
                        <canvas id="soilParametersChart"></canvas>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card card-body">
                        <h5 class="card-title">Soil Trends</h5>
                        <canvas id="soilTrendsChart"></canvas>
                    </div>
                </div>
            </div>

            <div class="d-flex mb-4">
                <div class="flex-grow-1">
                    <input v-model="searchQuery" type="search" class="form-control"
                        placeholder="Search soil conditions..." aria-label="Search">
                </div>
                <button class="btn btn-primary ms-3" @click="scrollToAddSoilCondition">
                    Add Soil Condition
                </button>
            </div>

            <div class="card mt-4">
                <div class="card-body">
                    <h5 class="card-title">Detailed Soil Condition List</h5>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead>
                                <tr>
                                    <th :class="TableHasText" style="width: 15%">Location</th>
                                    <th :class="TableHasText" style="width: 15%">Temperature</th>
                                    <th :class="TableHasText" style="width: 15%">Moisture</th>
                                    <th :class="TableHasText" style="width: 15%">pH Level</th>
                                    <th :class="TableHasText" style="width: 20%">Condition</th>
                                    <th :class="TableHasText" style="width: 20%" class="text-center">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="condition in paginatedConditions" :key="condition.id">
                                    <td :class="TableHasText">{{ condition.location }}</td>
                                    <td :class="TableHasText">{{ condition.temperature }}°C</td>
                                    <td :class="TableHasText">{{ condition.moisture }}%</td>
                                    <td :class="TableHasText">{{ condition.ph_level }}</td>
                                    <td :class="TableHasText">{{ condition.condition }}</td>
                                    <td :class="TableHasText" class="text-center">
                                        <button class="btn btn-warning btn-sm ms-3" @click="editCondition(condition)">
                                            <i class="fas fa-pencil"></i> Edit
                                        </button>
                                        <button class="btn btn-danger btn-sm ms-3" @click="deleteCondition(condition)">
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
                                Showing {{ startIndex + 1 }} to {{ endIndex }} of {{ filteredConditions.length }}
                                entries
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

            <div class="card mt-4" id="addSoilCondition">
                <div class="card-body">
                    <h5 class="card-title">Add Soil Condition</h5>
                    <form @submit.prevent="addSoilCondition">
                        <div class="mb-3">
                            <label for="location" class="form-label">Location</label>
                            <input v-model="newSoilCondition.location" type="text" class="form-control" id="location"
                                required>
                        </div>
                        <div class="mb-3">
                            <label for="temperature" class="form-label">Temperature (°C)</label>
                            <input v-model="newSoilCondition.temperature" type="number" class="form-control"
                                id="temperature" required>
                        </div>
                        <div class="mb-3">
                            <label for="moisture" class="form-label">Moisture (%)</label>
                            <input v-model="newSoilCondition.moisture" type="number" class="form-control" id="moisture"
                                required>
                        </div>
                        <div class="mb-3">
                            <label for="phLevel" class="form-label">pH Level</label>
                            <input v-model="newSoilCondition.ph_level" type="number" step="0.1" class="form-control"
                                id="phLevel" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Add Condition</button>
                    </form>
                </div>
            </div>

            <div class="modal fade" id="editCondition" tabindex="-1" aria-labelledby="editConditionLabel"
                aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editConditionLabel">Edit Soil Condition</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form @submit.prevent="updateSoilCondition" v-if="selectedCondition">
                                <div class="mb-3">
                                    <label for="editLocation" class="form-label">Location</label>
                                    <input v-model="selectedCondition.location" type="text" class="form-control"
                                        id="editLocation" required>
                                </div>
                                <div class="mb-3">
                                    <label for="editTemperature" class="form-label">Temperature (°C)</label>
                                    <input v-model="selectedCondition.temperature" type="number" class="form-control"
                                        id="editTemperature" required>
                                </div>
                                <div class="mb-3">
                                    <label for="editMoisture" class="form-label">Moisture (%)</label>
                                    <input v-model="selectedCondition.moisture" type="number" class="form-control"
                                        id="editMoisture" required>
                                </div>
                                <div class="mb-3">
                                    <label for="editPhLevel" class="form-label">pH Level</label>
                                    <input v-model="selectedCondition.ph_level" type="number" step="0.1"
                                        class="form-control" id="editPhLevel" required>
                                </div>
                                <button type="submit" class="btn btn-primary">Update Condition</button>
                            </form>
                            <p v-else>Loading...</p>
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
const soilConditions = ref([]);
const newSoilCondition = ref({ location: '', temperature: '', moisture: '', ph_level: '' });
const selectedCondition = ref(null);
const addSoilConditionSectionId = 'addSoilCondition';
const totalSoilConditions = computed(() => soilConditions.value.length);
const optimalConditions = computed(() => soilConditions.value.filter(condition =>
    condition.temperature >= 15 && condition.temperature <= 30 &&
    condition.moisture >= 40 && condition.moisture <= 60 &&
    condition.ph_level >= 6.0 && condition.ph_level <= 7.5
).length);
const warningConditions = computed(() => soilConditions.value.filter(condition =>
    condition.temperature < 10 || condition.temperature > 35 ||
    condition.moisture < 20 || condition.moisture > 80 ||
    condition.ph_level < 5.5 || condition.ph_level > 8.0
).length);

const fetchData = async () => {
    try {
        const response = await axios.get('/soil-conditions');
        soilConditions.value = response.data.map(condition => {
            let conditionStatus = '';

            if (condition.temperature >= 15 && condition.temperature <= 30 &&
                condition.moisture >= 40 && condition.moisture <= 60 &&
                condition.ph_level >= 6.0 && condition.ph_level <= 7.5) {
                conditionStatus = 'Optimal';
            } else {
                conditionStatus = 'Warning';
            }

            return {
                ...condition,
                condition: conditionStatus
            };
        });
    } catch (error) {
        console.error('Error fetching data:', error);
    }
};


const filteredConditions = computed(() => {
    if (!searchQuery.value) return soilConditions.value;
    return soilConditions.value.filter(condition =>
        condition.location.toLowerCase().includes(searchQuery.value.toLowerCase())
    );
});

const totalPages = computed(() => Math.ceil(filteredConditions.value.length / itemsPerPage));

const paginatedConditions = computed(() => {
    const start = (currentPage.value - 1) * itemsPerPage;
    const end = start + itemsPerPage;
    return filteredConditions.value.slice(start, end);
});

const startIndex = computed(() => (currentPage.value - 1) * itemsPerPage);
const endIndex = computed(() => Math.min(startIndex.value + itemsPerPage, filteredConditions.value.length));

const changePage = (page) => {
    if (page > 0 && page <= totalPages.value) {
        currentPage.value = page;
    }
};

const deleteCondition = async (condition) => {
    const result = await Swal.fire({
        title: 'Are you sure?',
        text: `Do you really want to delete the condition at ${condition.location}?`,
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, delete it!',
        cancelButtonText: 'Cancel'
    });

    if (result.isConfirmed) {
        try {
            await axios.delete(`/soil-conditions/${condition.id}`);
            await fetchData();
            Swal.fire(
                'Deleted!',
                `Condition at ${condition.location} has been deleted.`,
                'success'
            );
        } catch (error) {
            console.error('Error deleting condition:', error);
            Swal.fire(
                'Error!',
                'There was an error deleting the condition.',
                'error'
            );
        }
    }
};

const scrollToAddSoilCondition = () => {
    const section = document.getElementById(addSoilConditionSectionId);
    if (section) {
        section.scrollIntoView({ behavior: 'smooth' });
    }
};

const addSoilCondition = async () => {
    try {
        await axios.post('/soil-conditions', newSoilCondition.value);
        await fetchData();
        newSoilCondition.value = { location: '', temperature: '', moisture: '', ph_level: '', condition: '' };

        Swal.fire({
            title: 'Success!',
            text: 'Soil condition added successfully.',
            icon: 'success',
            confirmButtonText: 'OK'
        });
    } catch (error) {
        console.error('Error adding soil condition:', error);

        Swal.fire({
            title: 'Error!',
            text: 'There was an error adding the soil condition.',
            icon: 'error',
            confirmButtonText: 'OK'
        });
    }
};


const editCondition = (condition) => {
    selectedCondition.value = { ...condition };
    const modal = new bootstrap.Modal(document.getElementById('editCondition'));
    modal.show();
};

const updateSoilCondition = async () => {
    if (!selectedCondition.value.id) {
        Swal.fire({
            title: 'Error!',
            text: 'No condition selected for update.',
            icon: 'error',
            confirmButtonText: 'OK'
        });
        return;
    }

    try {
        await axios.put(`/soil-conditions/${selectedCondition.value.id}`, selectedCondition.value);
        await fetchData();
        selectedCondition.value = {
            id: null,
            location: '',
            temperature: '',
            moisture: '',
            ph_level: '',
            condition: ''
        };

        Swal.fire({
            title: 'Updated!',
            text: 'Soil condition updated successfully.',
            icon: 'success',
            confirmButtonText: 'OK'
        });

        const modal = bootstrap.Modal.getInstance(document.getElementById('editCondition'));
        modal.hide();
    } catch (error) {
        console.error('Error updating soil condition:', error);

        Swal.fire({
            title: 'Error!',
            text: 'There was an error updating the soil condition.',
            icon: 'error',
            confirmButtonText: 'OK'
        });
    }
};


const createSoilParametersChart = () => {
    const parametersCount = soilConditions.value.reduce((acc, condition) => {
        acc[condition.temperature] = acc[condition.temperature] ? acc[condition.temperature] + 1 : 1;
        return acc;
    }, {});

    const ctx = document.getElementById('soilParametersChart').getContext('2d');
    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: Object.keys(parametersCount),
            datasets: [{
                label: 'Soil Parameters Distribution',
                data: Object.values(parametersCount),
                backgroundColor: 'rgba(153, 102, 255, 0.2)',
                borderColor: 'rgba(153, 102, 255, 1)',
                borderWidth: 1
            }]
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

const createSoilTrendsChart = () => {
    const ctx = document.getElementById('soilTrendsChart').getContext('2d');

    const colors = [
        'rgba(139, 69, 19, 0.2)',
        'rgba(160, 82, 45, 0.2)',
        'rgba(205, 133, 63, 0.2)',
        'rgba(222, 184, 135, 0.2)',
        'rgba(210, 180, 140, 0.2)',
        'rgba(244, 164, 96, 0.2)',
        'rgba(188, 143, 143, 0.2)',
        'rgba(160, 82, 45, 0.2)'
    ];

    const borderColors = [
        'rgba(139, 69, 19, 1)',
        'rgba(160, 82, 45, 1)',
        'rgba(205, 133, 63, 1)',
        'rgba(222, 184, 135, 1)',
        'rgba(210, 180, 140, 1)',
        'rgba(244, 164, 96, 1)',
        'rgba(188, 143, 143, 1)',
        'rgba(160, 82, 45, 1)'
    ];

    new Chart(ctx, {
        type: 'line',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug'],
            datasets: soilConditions.value.map((condition, index) => ({
                label: condition.location,
                data: Array.from({ length: 8 }, (_, i) => Math.random() * 100),
                backgroundColor: colors[index % colors.length],
                borderColor: borderColors[index % borderColors.length],
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


onMounted(async () => {
    await fetchData();
    createSoilParametersChart();
    createSoilTrendsChart();
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
