<template>
    <AppLayout title="Farm Dashboard">
        <template #page-title> Farm Dashboard </template>

        <template #content>
            <div class="row g-4 mb-5">
                <div class="col-md-6 col-xxl-4">
                    <div
                        class="card card-body bg-warning bg-opacity-10 border border-warning border-opacity-25 p-4 h-100">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h4 class="mb-0">Welcome!</h4>
                                <span class="h6 fw-light mb-0">{{ user.name }}</span>
                            </div>
                            <div class="icon-lg rounded-circle bg-warning text-dark mb-0">
                                <i class="fa-solid fa-user fa-fw"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-xxl-4">
                    <div class="card card-body bg-info bg-opacity-10 border border-info border-opacity-25 p-4 h-100">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h4 class="mb-0">{{ totalItems }}</h4>
                                <span class="h6 fw-light mb-0">Total Inventory Items</span>
                            </div>
                            <div class="icon-lg rounded-circle bg-info text-white mb-0">
                                <i class="fa-solid fa-boxes fa-fw"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 col-xxl-4">
                    <div
                        class="card card-body bg-success bg-opacity-10 border border-success border-opacity-25 p-4 h-100">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h4 class="mb-0">{{ totalCrops }}</h4>
                                <span class="h6 fw-light mb-0">Total Crops</span>
                            </div>
                            <div class="icon-lg rounded-circle bg-success text-white mb-0">
                                <i class="fa-solid fa-Seedling fa-fw"></i>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <div class="card mt-4">
                <div class="card-body">
                    <h5 class="card-title">Farm Data Overview</h5>
                    <div class="row">
                        <div class="col-md-6">
                            <canvas id="cropGrowthChart"></canvas>
                        </div>
                        <div class="col-md-6">
                            <canvas id="inventoryTrendsChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card mt-4">
                <div class="card-body">
                    <h5 class="card-title">Special Notes and Reminders</h5>
                    <div class="sticky-notes-container">
                        <button class="btn btn-primary mb-3" @click="openModal()">Add New Note</button>
                        <div class="row">
                            <div class="col-md-4" v-for="note in notes" :key="note.id">
                                <div class="sticky-note card">
                                    <div class="card-body">
                                        <h5 class="card-title">{{ note.title }}</h5>
                                        <p class="card-text">
                                            {{ truncateText(note.body) }}
                                        </p>
                                        <div class="d-flex justify-content-between">
                                            <small>{{ note.date }}</small>
                                            <small>{{ note.time }}</small>
                                        </div>
                                        <div class="d-flex justify-content-end">
                                            <button class="btn btn-info mt-2 me-2" @click="viewNoteModal(note)">
                                                <i class="fa-solid fa-eye"></i>
                                            </button>
                                            <button class="btn btn-warning mt-2 me-2" @click="openModal(note)"><i
                                                    class="fa-solid fa-pencil"></i></button>
                                            <button class="btn btn-danger mt-2" @click="deleteNote(note.id)"><i
                                                    class="fa-solid fa-trash-alt"></i></button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="stickyNoteModal" tabindex="-1" aria-labelledby="stickyNoteModalLabel"
                aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="stickyNoteModalLabel">{{ modalNote ? 'Edit Note' : 'Add Note' }}
                            </h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form @submit.prevent="saveNote">
                                <div class="mb-3">
                                    <label for="noteTitle" class="form-label">Title</label>
                                    <input type="text" v-model="modalNote.title" class="form-control" id="noteTitle"
                                        required />
                                </div>
                                <div class="mb-3">
                                    <label for="noteBody" class="form-label">Body</label>
                                    <textarea v-model="modalNote.body" class="form-control" id="noteBody" rows="3"
                                        required></textarea>
                                </div>
                                <div class="mb-3">
                                    <label for="noteDate" class="form-label">Date</label>
                                    <input type="date" v-model="modalNote.date" class="form-control" id="noteDate"
                                        readonly />
                                </div>
                                <div class="mb-3">
                                    <label for="noteTime" class="form-label">Time</label>
                                    <input type="time" v-model="modalNote.time" class="form-control" id="noteTime"
                                        readonly />
                                </div>
                                <button type="submit" class="btn btn-primary">{{ modalNote.id ? 'Update Note' :
                                    'SaveNote' }}</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="viewNoteModal" tabindex="-1" aria-labelledby="viewNoteModalLabel"
                aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="viewNoteModalLabel">{{ viewModalNote.title }}</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p>{{ viewModalNote.body }}</p>
                            <small>{{ viewModalNote.date }} at {{ viewModalNote.time }}</small>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>







        </template>
    </AppLayout>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { Link, usePage } from '@inertiajs/vue3';
import AppLayout from "@/Layouts/AppLayout.vue";
import { Chart, registerables } from "chart.js";
import Swal from 'sweetalert2';

Chart.register(...registerables);

const props = defineProps({
    cropCount: Array,
    itemCount: Array,
});

const totalItems = ref(0);

const fetchInventoryItems = async () => {
    try {
        const response = await axios.get('/items');
        totalItems.value = response.data.reduce((total, item) => total + item.quantity, 0);
    } catch (error) {
        console.error('Error fetching inventory items:', error);
    }
};

const truncateText = (text, limit = 30) => {
    if (!text) return '';
    const words = text.split(' ');
    return words.length > limit ? words.slice(0, limit).join(' ') + '...' : text;
};

const { props: pageProps } = usePage();
const user = pageProps.auth.user;

const totalCrops = ref(0);

const fetchTotalCrops = async () => {
    try {
        const response = await axios.get('/crops');
        totalCrops.value = response.data.length;
    } catch (error) {
        console.error('Error fetching total crops:', error);
    }
};

const cropGrowthData = {
    labels: "",
    datasets: [
        {
            label: "Crops To Be Harvested",
            data: props.cropCount,
            borderColor: "rgb(75, 192, 192)",
            backgroundColor: "rgba(75, 192, 192, 0.2)",
            fill: true,
        },
    ],
};

const inventoryTrendsData = {
    labels: "",
    datasets: [
        {
            label: "Inventory Levels",
            data: props.itemCount,
            borderColor: "rgb(255, 99, 132)",
            backgroundColor: "rgba(255, 99, 132, 0.2)",
            fill: true,
        },
    ],
};

const notes = ref([]);
const modalNote = ref({
    id: null,
    title: '',
    body: '',
    date: '',
    time: ''
});

const viewModalNote = ref({
    title: '',
    body: '',
    date: '',
    time: ''
});

const openModal = (note = { title: '', body: '', date: new Date().toISOString().split('T')[0], time: new Date().toLocaleTimeString('en-GB').slice(0, 5) }) => {
    modalNote.value = { ...note };
    new bootstrap.Modal(document.getElementById('stickyNoteModal')).show();
};

const viewNoteModal = (note) => {
    viewModalNote.value = { ...note };
    new bootstrap.Modal(document.getElementById('viewNoteModal')).show();
};

const saveNote = async () => {
    try {
        modalNote.value.date = new Date().toISOString().split('T')[0];
        modalNote.value.time = new Date().toLocaleTimeString('en-GB').slice(0, 5);

        if (modalNote.value.id) {
            await axios.put(`/notes/${modalNote.value.id}`, modalNote.value);
            Swal.fire({
                title: 'Updated!',
                text: 'Your note has been updated successfully.',
                icon: 'success',
                confirmButtonText: 'Ok'
            });
        } else {
            await axios.post('/notes', modalNote.value);
            Swal.fire({
                title: 'Added!',
                text: 'Your note has been added successfully.',
                icon: 'success',
                confirmButtonText: 'Ok'
            });
        }
        await fetchNotes();
        const modalElement = document.getElementById('stickyNoteModal');
        const modal = bootstrap.Modal.getInstance(modalElement);
        modal.hide();
    } catch (error) {
        console.error('Error saving note:', error);
        Swal.fire({
            title: 'Error!',
            text: 'There was an issue saving your note.',
            icon: 'error',
            confirmButtonText: 'Ok'
        });
    }
};


const deleteNote = async (id) => {
    try {
        const result = await Swal.fire({
            title: 'Are you sure?',
            text: "You won't be able to revert this!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, delete it!'
        });

        if (result.isConfirmed) {
            await axios.delete(`/notes/${id}`);
            await fetchNotes();
            Swal.fire(
                'Deleted!',
                'Your note has been deleted.',
                'success'
            );
        }
    } catch (error) {
        console.error('Error deleting note:', error);
    }
};

const fetchNotes = async () => {
    try {
        const response = await axios.get('/notes');
        notes.value = response.data;
    } catch (error) {
        console.error('Error fetching notes:', error);
    }
};


onMounted(() => {

    fetchNotes();

    fetchInventoryItems();

    fetchTotalCrops();

    const cropGrowthChartCtx = document
        .getElementById("cropGrowthChart")
        .getContext("2d");
    new Chart(cropGrowthChartCtx, {
        type: "line",
        data: cropGrowthData,
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: "top",
                },
                tooltip: {
                    callbacks: {
                        label: function (tooltipItem) {
                            return (
                                tooltipItem.dataset.label +
                                ": " +
                                tooltipItem.formattedValue +
                                "%"
                            );
                        },
                    },
                },
            },
            scales: {
                x: {
                    title: {
                        display: true,
                        text: "Month",
                    },
                },
                y: {
                    title: {
                        display: true,
                        text: "Number",
                    },
                },
            },
        },
    });

    const inventoryTrendsChartCtx = document
        .getElementById("inventoryTrendsChart")
        .getContext("2d");
    new Chart(inventoryTrendsChartCtx, {
        type: "line",
        data: inventoryTrendsData,
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: "top",
                },
                tooltip: {
                    callbacks: {
                        label: function (tooltipItem) {
                            return (
                                tooltipItem.dataset.label +
                                ": " +
                                tooltipItem.formattedValue +
                                "%"
                            );
                        },
                    },
                },
            },
            scales: {
                x: {
                    title: {
                        display: true,
                        text: "Month",
                    },
                },
                y: {
                    title: {
                        display: true,
                        text: "Number",
                    },
                },
            },
        },
    });
});
</script>

<style lang="scss">
.card {
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.icon-lg {
    font-size: 2rem;
}

.card-body {
    padding: 1.5rem;
}

.card-title {
    margin-bottom: 1rem;
}

.list-unstyled {
    padding-left: 0;
}

.list-unstyled li {
    padding: 0.5rem 0;
}

.alert {
    margin-bottom: 0.5rem;
}

canvas {
    max-width: 100%;
}

.sticky-notes-container {
    display: flex;
    flex-direction: column;
    gap: 1rem;
    /* Add space between notes */
}

.sticky-note {
    background: #fffae6;
    border: 1px solid #f0e6a8;
    border-radius: 8px;
    padding: 1rem;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    position: relative;
    overflow: hidden;
}

.sticky-note .btn {
    font-size: 0.8rem;
}

.sticky-note .note-content {
    max-height: 4.5rem;
    /* Limit height to 15 words or so */
    overflow: hidden;
    text-overflow: ellipsis;
}

.sticky-note .note-actions {
    position: absolute;
    bottom: 0.5rem;
    right: 0.5rem;
    display: flex;
    gap: 0.5rem;
}

.sticky-note .note-actions .btn {
    font-size: 0.75rem;
    padding: 0.25rem 0.5rem;
}
</style>
