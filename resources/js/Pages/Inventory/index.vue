<template>
    <AppLayout title="Inventory Management">
        <template #page-title> Inventory Management </template>
        <template #content>
            <div class="row g-4 mb-5">
                <div class="col-md-6 col-xxl-3">
                    <div
                        class="card card-body bg-primary bg-opacity-10 border border-primary border-opacity-25 p-4 h-100">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h4 class="mb-0">{{ totalSeeds }}</h4>
                                <span class="h6 fw-light mb-0">Total Seeds</span>
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
                                <h4 class="mb-0">{{ totalFertilizers }}</h4>
                                <span class="h6 fw-light mb-0">Total Fertilizers</span>
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
                                <h4 class="mb-0">{{ totalPesticides }}</h4>
                                <span class="h6 fw-light mb-0">Total Pesticides</span>
                            </div>
                            <div class="icon-lg rounded-circle bg-warning text-white mb-0">
                                <i class="fa-solid fa-spray-can fa-fw"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 col-xxl-3">
                    <div
                        class="card card-body bg-danger bg-opacity-10 border border-danger border-opacity-25 p-4 h-100">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h4 class="mb-0">{{ totalOtherItems }}</h4>
                                <span class="h6 fw-light mb-0">Other Items</span>
                            </div>
                            <div class="icon-lg rounded-circle bg-danger text-white mb-0">
                                <i class="fa-solid fa-box fa-fw"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row g-4 mb-5">
                <div class="col-md-6">
                    <div class="card card-body">
                        <h5 class="card-title">Stock Levels</h5>
                        <canvas id="stockLevelsChart"></canvas>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card card-body">
                        <h5 class="card-title">Stock Trends</h5>
                        <canvas id="stockTrendsChart"></canvas>
                    </div>
                </div>
            </div>

            <div class="d-flex mb-4">
                <div class="flex-grow-1">
                    <input v-model="searchQuery" class="form-control" type="search" placeholder="Search Inventory"
                        aria-label="Search" />
                </div>

                <button class="btn btn-primary ms-3" @click="prepareAddItem">
                    Add Item
                </button>
            </div>

            <div class="card mt-4">
                <div class="card-body">
                    <h5 class="card-title">Detailed Inventory List</h5>
                    <div class="table-responsive" style="width: 100%">
                        <table class="table table-hover align-middle" style="width: 100%">
                            <thead>
                                <tr>
                                    <th :class="TableHasText" style="width: 20%">
                                        Item
                                    </th>
                                    <th :class="TableHasText" style="width: 15%">
                                        Category
                                    </th>
                                    <th :class="TableHasText" style="width: 15%">
                                        Quantity
                                    </th>
                                    <th :class="TableHasText" style="width: 20%">
                                        Purchase Date
                                    </th>
                                    <th :class="TableHasText" style="width: 15%">
                                        Usage
                                    </th>
                                    <th :class="TableHasText" class="text-center" style="width: 15%">
                                        Actions
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="item in paginatedItems.items" :key="item.id">
                                    <td :class="TableHasText" style="width: 20%">
                                        {{ item.name }}
                                    </td>
                                    <td :class="TableHasText" style="width: 15%">
                                        {{ item.category_name }}
                                    </td>
                                    <td :class="TableHasText" style="width: 15%">
                                        {{ item.quantity }}
                                    </td>
                                    <td :class="TableHasText" style="width: 20%">
                                        {{ item.purchase_date }}
                                    </td>
                                    <td :class="TableHasText" style="width: 15%">
                                        {{ item.usage }}
                                    </td>
                                    <td :class="TableHasText" style="width: 15%">
                                        <button class="btn btn-warning btn-sm me-2" @click="editItem(item)">
                                            <i class="fas fa-edit"></i> Edit
                                        </button>
                                        <button class="btn btn-danger btn-sm" @click="deleteItem(item.id)">
                                            <i class="fas fa-trash-alt"></i>
                                            Delete
                                        </button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="pt-3 table-footer">
                        <div class="d-sm-flex justify-content-sm-between align-items-sm-center">
                            <p class="mb-sm-0 text-center text-sm-start">
                                Showing {{ paginatedItems.from }} to
                                {{ paginatedItems.to }} of
                                {{ paginatedItems.total }} entries
                            </p>
                            <nav class="mb-sm-0 d-flex justify-content-center" aria-label="navigation">
                                <ul class="pagination pagination-sm pagination-primary-soft mb-0">
                                    <li class="page-item" :class="{
                                        disabled: !pagination.hasPrev,
                                    }">
                                        <a class="page-link" @click="
                                            changePage(
                                                pagination.currentPage - 1
                                            )
                                            ">Prev</a>
                                    </li>
                                    <li v-for="page in pagination.pages" :key="page" class="page-item" :class="{
                                        active:
                                            page === pagination.currentPage,
                                    }">
                                        <a class="page-link" @click="changePage(page)">{{ page }}</a>
                                    </li>
                                    <li class="page-item" :class="{
                                        disabled: !pagination.hasNext,
                                    }">
                                        <a class="page-link" @click="
                                            changePage(
                                                pagination.currentPage + 1
                                            )
                                            ">Next</a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="addEditInventoryModal" tabindex="-1"
                aria-labelledby="addEditInventoryModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-md">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addEditInventoryModalLabel">
                                {{ isEditing ? "Edit" : "Add" }} Inventory Item
                            </h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form @submit.prevent="saveInventoryItem">
                                <div class="mb-3">
                                    <label for="itemName" class="form-label">Item Name</label>
                                    <input v-model="currentItem.name" type="text" class="form-control" id="itemName"
                                        required />
                                </div>
                                <div class="mb-3">
                                    <label for="itemCategory" class="form-label">Category</label>
                                    <select v-model="currentItem.category_id" class="form-select" id="itemCategory"
                                        required>
                                        <option v-for="category in categories" :key="category.id" :value="category.id">
                                            {{ category.name }}
                                        </option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="quantity" class="form-label">Quantity</label>
                                    <input v-model="currentItem.quantity" type="number" class="form-control"
                                        id="quantity" required />
                                </div>
                                <div class="mb-3">
                                    <label for="purchaseDate" class="form-label">Purchase Date</label>
                                    <input v-model="currentItem.purchase_date" type="date" class="form-control"
                                        id="purchaseDate" required />
                                </div>
                                <div class="mb-3">
                                    <label for="usage" class="form-label">Usage</label>
                                    <input v-model="currentItem.usage" type="text" class="form-control" id="usage"
                                        required />
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                        Close
                                    </button>
                                    <button type="submit" class="btn btn-primary">
                                        Save changes
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </template>

        <template #preloader> </template>
    </AppLayout>
</template>

<script setup>
import { ref, computed, onMounted, watch } from "vue";
import axios from "axios";
import { Chart, registerables } from "chart.js";
import AppLayout from "@/Layouts/AppLayout.vue";
import Swal from "sweetalert2";

Chart.register(...registerables);

const props = defineProps({
    currentMonthDates: Array,
});

const TableHasText = ref("text-start");

const totalSeeds = ref(0);
const totalFertilizers = ref(0);
const totalPesticides = ref(0);
const totalOtherItems = ref(0);

const categories = ref([]);
const inventoryItems = ref([]);
const date = ref(new Date().toISOString().substr(0, 10));

const searchQuery = ref("");
const selectedCategory = ref("");
const currentItem = ref({
    id: null,
    name: "",
    category: "Seed",
    quantity: 0,
    purchase_date: "",
    usage: "",
});
const isEditing = ref(false);
const itemsPerPage = 5;
const currentPage = ref(1);

let stockLevelsChart = null;

const filteredInventoryItems = computed(() => {
    return inventoryItems.value.filter((item) => {
        return (
            (!selectedCategory.value ||
                item.category === selectedCategory.value) &&
            (item.name
                .toLowerCase()
                .includes(searchQuery.value.toLowerCase()) ||
                searchQuery.value === "")
        );
    });
});

const paginatedItems = computed(() => {
    const start = (currentPage.value - 1) * itemsPerPage;
    const end = start + itemsPerPage;
    const paginated = filteredInventoryItems.value.slice(start, end);
    return {
        items: paginated,
        from: start + 1,
        to:
            end > filteredInventoryItems.value.length
                ? filteredInventoryItems.value.length
                : end,
        total: filteredInventoryItems.value.length,
        pages: Math.ceil(filteredInventoryItems.value.length / itemsPerPage),
    };
});

const pagination = computed(() => ({
    pages: Array.from({ length: paginatedItems.value.pages }, (_, i) => i + 1),
    currentPage: currentPage.value,
    hasPrev: currentPage.value > 1,
    hasNext: currentPage.value < paginatedItems.value.pages,
}));

const changePage = (page) => {
    if (page >= 1 && page <= paginatedItems.value.pages) {
        currentPage.value = page;
    }
};

const prepareAddItem = () => {
    const today = new Date().toISOString().split("T")[0];
    currentItem.value = {
        id: null,
        name: "",
        category: "Seed",
        quantity: 0,
        purchase_date: today,
        usage: "",
    };
    isEditing.value = false;
    new bootstrap.Modal(
        document.getElementById("addEditInventoryModal")
    ).show();
};

const countItemsByCategory = () => {
    const counts = {
        Seeds: 0,
        Fertilizers: 0,
        Pesticides: 0,
        Other: 0,
    };

    inventoryItems.value.forEach((item) => {
        if (item.category_name === "Seeds") counts.Seeds++;
        else if (item.category_name === "Fertilizers") counts.Fertilizers++;
        else if (item.category_name === "Pesticides") counts.Pesticides++;
        else counts.Other++;
    });

    totalSeeds.value = counts.Seeds;
    totalFertilizers.value = counts.Fertilizers;
    totalPesticides.value = counts.Pesticides;
    totalOtherItems.value = counts.Other;
};

const countItemsByQuantity = () => {
    const counts = {
        Seeds: 0,
        Fertilizers: 0,
        Pesticides: 0,
        Other: 0,
    };

    inventoryItems.value.forEach((item) => {
        if (item.category_name === "Seeds") counts.Seeds += item.quantity;
        else if (item.category_name === "Fertilizers")
            counts.Fertilizers += item.quantity;
        else if (item.category_name === "Pesticides")
            counts.Pesticides += item.quantity;
        else counts.Other += item.quantity;
    });

    if (stockLevelsChart) {
        stockLevelsChart.data.datasets[0].data = [
            counts.Seeds,
            counts.Fertilizers,
            counts.Pesticides,
            counts.Other,
        ];
        stockLevelsChart.update();
    }
};

const allItems = ref([]);

const fetchInventoryItems = async () => {
    try {
        const response = await axios.get("/items");
        inventoryItems.value = response.data;
        allItems.value = response.data;
        countItemsByCategory();
        countItemsByQuantity();
    } catch (error) {
        console.error("Error fetching inventory items:", error);
    }
};

const editItem = (item) => {
    currentItem.value = { ...item };
    isEditing.value = true;
    new bootstrap.Modal(
        document.getElementById("addEditInventoryModal")
    ).show();
};

const saveInventoryItem = async () => {
    try {
        let response;
        if (isEditing.value) {
            response = await axios.put(
                `/items/${currentItem.value.id}`,
                currentItem.value
            );
            const index = inventoryItems.value.findIndex(
                (item) => item.id === currentItem.value.id
            );
            if (index !== -1) {
                inventoryItems.value[index] = response.data;
            }
        } else {
            response = await axios.post("/items", currentItem.value);
            inventoryItems.value.push(response.data);
        }

        Swal.fire({
            icon: "success",
            title: "Success",
            text: `Inventory item ${isEditing.value ? "updated" : "added"
                } successfully!`,
            confirmButtonText: "OK",
        });

        const modal = bootstrap.Modal.getInstance(
            document.getElementById("addEditInventoryModal")
        );
        modal.hide();
        countItemsByCategory();
        countItemsByQuantity();
    } catch (error) {
        console.error("Error saving inventory item:", error);
        Swal.fire({
            icon: "error",
            title: "Error",
            text: "Failed to save inventory item. Please try again.",
            confirmButtonText: "OK",
        });
    }
};

const deleteItem = async (itemId) => {
    try {
        const result = await Swal.fire({
            title: 'Are you sure?',
        text: `Do you really want to delete this item?`,
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, delete it!',
        cancelButtonText: 'Cancel'
        });

        if (result.isConfirmed) {
            await axios.delete(`/items/${itemId}`);
            inventoryItems.value = inventoryItems.value.filter(
                (item) => item.id !== itemId
            );

            Swal.fire({
                icon: "success",
                title: "Deleted!",
                text: "The item has been deleted.",
                confirmButtonText: "OK",
            });

            countItemsByCategory();
            countItemsByQuantity();
        }
    } catch (error) {
        console.error("Error deleting inventory item:", error);
        Swal.fire({
            icon: "error",
            title: "Error",
            text: "Failed to delete inventory item. Please try again.",
            confirmButtonText: "OK",
        });
    }
};

const fetchCategories = async () => {
    try {
        const response = await axios.get("/categories");
        categories.value = response.data;
    } catch (error) {
        console.error("Error fetching categories:", error);
    }
};

const updateStockLevelsChart = () => {
    if (stockLevelsChart) {
        stockLevelsChart.data.datasets[0].data = [
            totalSeeds.value,
            totalFertilizers.value,
            totalPesticides.value,
            totalOtherItems.value,
        ];
        stockLevelsChart.update();
    }
};

const createStockLevelsChart = () => {
    const ctx = document.getElementById("stockLevelsChart").getContext("2d");
    stockLevelsChart = new Chart(ctx, {
        type: "bar",
        data: {
            labels: ["Seeds", "Fertilizers", "Pesticides", "Other Items"],
            datasets: [
                {
                    data: [0, 0, 0, 0],
                    backgroundColor: [
                        "rgba(156, 154, 108, 0.2)",
                        "rgba(25, 135, 84, 0.2)",
                        "rgba(255, 193, 7, 0.2)",
                        "rgba(220, 53, 69, 0.2)",
                    ],
                    borderColor: [
                        "rgba(156, 154, 108, 1)",
                        "rgba(25, 135, 84, 1)",
                        "rgba(255, 193, 7, 1)",
                        "rgba(220, 53, 69, 1)",
                    ],
                    borderWidth: 1,
                },
            ],
        },
        options: {
            plugins: {
                legend: {
                    display: false,
                },
            },
            scales: {
                y: {
                    beginAtZero: true,
                },
            },
        },
    });
};

const now = new Date();

const currentMonth = now.getMonth();
const currentYear = now.getFullYear();
const daysInMonth = new Date(currentYear, currentMonth + 1, 0).getDate();
const daysArray = Array.from({ length: daysInMonth }, (_, i) => i + 1);
const createStockTrendsChart = () => {
    const ctx = document.getElementById("stockTrendsChart").getContext("2d");
    const stockTrendsChart = new Chart(ctx, {
        type: "line",
        data: {
            labels: "",
            datasets: [
                {
                    label: "Purchased Items",
                    data: props.currentMonthDates,
                    fill: false,
                    borderColor: "rgb(75, 192, 192)",
                    tension: 0.1,
                },
            ],
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true,
                },
            },
        },
    });
};

onMounted(() => {
    fetchCategories();
    fetchInventoryItems();
    createStockLevelsChart();
    createStockTrendsChart();
});

watch(
    inventoryItems,
    () => {
        countItemsByCategory();
        countItemsByQuantity();
    },
    { deep: true }
);
</script>
