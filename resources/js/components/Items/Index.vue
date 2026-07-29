<template>
    <div class="space-y-6 text-black">
        <!-- Header Section -->
        <div
            class="flex flex-col sm:flex-row sm:justify-between sm:items-center bg-white p-6 border-2 border-black gap-4 sm:gap-0"
        >
            <div>
                <h2 class="text-3xl font-black uppercase tracking-tight">
                    Master Barang
                </h2>
                <p class="text-sm font-medium mt-1">
                    Kelola data inventaris dan pantau stok barang Anda.
                </p>
            </div>
            <button
                @click="
                    showAddForm = !showAddForm;
                    showEditForm = false;
                "
                class="bg-black hover:bg-white hover:text-black text-white font-bold py-3 px-6 border-2 border-black transition-colors duration-200 flex items-center space-x-2"
            >
                <svg
                    class="w-5 h-5"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                >
                    <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M12 4v16m8-8H4"
                    ></path>
                </svg>
                <span class="uppercase tracking-wider text-sm">{{
                    showAddForm ? "Tutup Form" : "Tambah Barang"
                }}</span>
            </button>
        </div>

        <!-- Add Form -->
        <transition name="slide-down">
            <div
                v-if="showAddForm"
                class="bg-white p-8 border-2 border-black relative"
            >
                <h3 class="text-xl font-black mb-6 uppercase flex items-center">
                    <span class="bg-black text-white p-1 mr-3">
                        <svg
                            class="w-5 h-5"
                            fill="none"
                            stroke="currentColor"
                            viewBox="0 0 24 24"
                        >
                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                stroke-width="2"
                                d="M9 13h6m-3-3v6m5 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"
                            ></path>
                        </svg>
                    </span>
                    Input Barang Baru
                </h3>
                <form @submit.prevent="addItem">
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                        <div>
                            <label
                                class="block text-sm font-bold uppercase tracking-wider mb-2"
                                >Nama Barang</label
                            >
                            <input
                                v-model="form.name"
                                type="text"
                                required
                                placeholder="Contoh : Laptop Asus"
                                class="block w-full border-2 border-black bg-white focus:ring-0 focus:outline-none text-sm py-3 px-4 font-medium transition-colors"
                            />
                        </div>
                        <div>
                            <label
                                class="block text-sm font-bold uppercase tracking-wider mb-2"
                                >Satuan</label
                            >
                            <CustomSelect
                                v-model="form.unit"
                                :options="unitOptions"
                                placeholder="Pilih Satuan"
                            />
                        </div>
                        <div>
                            <label
                                class="block text-sm font-bold uppercase tracking-wider mb-2"
                                >Stok Awal</label
                            >
                            <input
                                v-model="form.initial_stock"
                                type="number"
                                required
                                min="0"
                                class="block w-full border-2 border-black bg-white focus:ring-0 focus:outline-none text-sm py-3 px-4 font-medium transition-colors"
                            />
                        </div>
                    </div>
                    <div class="mt-8 flex justify-end space-x-4">
                        <button
                            type="button"
                            @click="showAddForm = false"
                            class="bg-white border-2 border-black hover:bg-gray-100 text-black font-bold py-3 px-8 uppercase tracking-wider text-sm transition-colors"
                        >
                            Batal
                        </button>
                        <button
                            type="submit"
                            class="bg-black hover:bg-white hover:text-black border-2 border-black text-white font-bold py-3 px-10 uppercase tracking-wider text-sm transition-colors"
                        >
                            Simpan
                        </button>
                    </div>
                </form>
            </div>
        </transition>

        <!-- Edit Form -->
        <transition name="slide-down">
            <div
                v-if="showEditForm"
                class="bg-white p-8 border-2 border-black relative mt-6"
            >
                <h3 class="text-xl font-black mb-6 uppercase flex items-center">
                    <span class="bg-black text-white p-1 mr-3">
                        <svg
                            class="w-5 h-5"
                            fill="none"
                            stroke="currentColor"
                            viewBox="0 0 24 24"
                        >
                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                stroke-width="2"
                                d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"
                            ></path>
                        </svg>
                    </span>
                    Edit Barang: {{ editForm.item_code }}
                </h3>
                <form @submit.prevent="updateItem">
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                        <div>
                            <label
                                class="block text-sm font-bold uppercase tracking-wider mb-2"
                                >Nama Barang</label
                            >
                            <input
                                v-model="editForm.name"
                                type="text"
                                required
                                class="block w-full border-2 border-black bg-white focus:ring-0 focus:outline-none text-sm py-3 px-4 font-medium transition-colors"
                            />
                        </div>
                        <div>
                            <label
                                class="block text-sm font-bold uppercase tracking-wider mb-2"
                                >Satuan</label
                            >
                            <CustomSelect
                                v-model="editForm.unit"
                                :options="unitOptions"
                                placeholder="Pilih Satuan..."
                            />
                        </div>
                        <div>
                            <label
                                class="block text-sm font-bold uppercase tracking-wider mb-2"
                                >Stok Awal</label
                            >
                            <input
                                v-model="editForm.initial_stock"
                                type="number"
                                required
                                min="0"
                                class="block w-full border-2 border-black bg-white focus:ring-0 focus:outline-none text-sm py-3 px-4 font-medium transition-colors"
                            />
                        </div>
                    </div>
                    <div class="mt-8 flex justify-end space-x-4">
                        <button
                            type="button"
                            @click="showEditForm = false"
                            class="bg-white border-2 border-black hover:bg-gray-100 text-black font-bold py-3 px-8 uppercase tracking-wider text-sm transition-colors"
                        >
                            Batal
                        </button>
                        <button
                            type="submit"
                            class="bg-black hover:bg-white hover:text-black border-2 border-black text-white font-bold py-3 px-10 uppercase tracking-wider text-sm transition-colors"
                        >
                            Update
                        </button>
                    </div>
                </form>
            </div>
        </transition>

        <!-- Table -->
        <div class="bg-white border-2 border-black overflow-hidden">
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y-2 divide-black">
                    <thead class="bg-black text-white">
                        <tr>
                            <th
                                scope="col"
                                class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider border-r border-gray-700"
                            >
                                Kode
                            </th>
                            <th
                                scope="col"
                                class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider border-r border-gray-700"
                            >
                                Nama Barang
                            </th>
                            <th
                                scope="col"
                                class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider border-r border-gray-700"
                            >
                                Satuan
                            </th>
                            <th
                                scope="col"
                                class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider border-r border-gray-700"
                            >
                                Stok Saat Ini
                            </th>
                            <th
                                scope="col"
                                class="px-6 py-4 text-right text-sm font-bold uppercase tracking-wider"
                            >
                                Aksi
                            </th>
                        </tr>
                    </thead>
                    <tbody class="divide-y-2 divide-black bg-white">
                        <tr
                            v-for="item in items"
                            :key="item.id"
                            class="hover:bg-gray-100 transition-colors group"
                        >
                            <td
                                class="px-6 py-4 whitespace-nowrap border-r border-black"
                            >
                                <span class="font-bold font-mono">{{
                                    item.item_code
                                }}</span>
                            </td>
                            <td
                                class="px-6 py-4 whitespace-nowrap text-sm font-bold border-r border-black"
                            >
                                {{ item.name }}
                            </td>
                            <td
                                class="px-6 py-4 whitespace-nowrap text-sm border-r border-black"
                            >
                                <span
                                    class="inline-flex items-center px-3 py-1 border-2 border-black text-xs font-bold uppercase"
                                    >{{ item.unit }}</span
                                >
                            </td>
                            <td
                                class="px-6 py-4 whitespace-nowrap border-r border-black"
                            >
                                <div class="flex items-center">
                                    <span class="text-xl font-black">{{
                                        item.final_stock
                                    }}</span>
                                </div>
                            </td>
                            <td
                                class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium"
                            >
                                <button
                                    @click="openEditForm(item)"
                                    class="text-black border-2 border-transparent hover:border-black p-2 transition-colors mr-2"
                                    title="Edit"
                                >
                                    <svg
                                        class="w-5 h-5"
                                        fill="none"
                                        stroke="currentColor"
                                        viewBox="0 0 24 24"
                                    >
                                        <path
                                            stroke-linecap="round"
                                            stroke-linejoin="round"
                                            stroke-width="2"
                                            d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"
                                        ></path>
                                    </svg>
                                </button>
                                <button
                                    @click="deleteItem(item.id)"
                                    class="text-white bg-black border-2 border-black hover:bg-white hover:text-black p-2 transition-colors"
                                    title="Hapus"
                                >
                                    <svg
                                        class="w-5 h-5"
                                        fill="none"
                                        stroke="currentColor"
                                        viewBox="0 0 24 24"
                                    >
                                        <path
                                            stroke-linecap="round"
                                            stroke-linejoin="round"
                                            stroke-width="2"
                                            d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"
                                        ></path>
                                    </svg>
                                </button>
                            </td>
                        </tr>
                        <tr v-if="items.length === 0">
                            <td
                                colspan="5"
                                class="px-6 py-12 text-center border-t-2 border-black"
                            >
                                <div
                                    class="flex flex-col items-center justify-center text-black"
                                >
                                    <svg
                                        class="w-12 h-12 mb-3"
                                        fill="none"
                                        stroke="currentColor"
                                        viewBox="0 0 24 24"
                                    >
                                        <path
                                            stroke-linecap="round"
                                            stroke-linejoin="round"
                                            stroke-width="1.5"
                                            d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4"
                                        ></path>
                                    </svg>
                                    <span
                                        class="text-sm font-bold uppercase tracking-wider"
                                        >Belum ada data barang.</span
                                    >
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</template>

<script>
import axios from "axios";
import CustomSelect from "../CustomSelect.vue";

export default {
    components: { CustomSelect },
    data() {
        return {
            items: [],
            showAddForm: false,
            showEditForm: false,
            unitOptions: [
                { value: "pcs", label: "Pcs (Pieces)" },
                { value: "box", label: "Box (Kotak)" },
                { value: "kg", label: "Kg (Kilogram)" },
                { value: "liter", label: "Liter" },
                { value: "meter", label: "Meter" },
                { value: "roll", label: "Roll" },
            ],
            form: {
                name: "",
                unit: "",
                initial_stock: 0,
            },
            editForm: {},
        };
    },
    mounted() {
        this.fetchItems();
    },
    methods: {
        async fetchItems() {
            try {
                const response = await axios.get("/api/items");
                this.items = response.data;
            } catch (error) {
                console.error("Error fetching items:", error);
            }
        },
        async addItem() {
            try {
                await axios.post("/api/items", this.form);
                this.form = { name: "", unit: "", initial_stock: 0 };
                this.showAddForm = false;
                this.fetchItems();
            } catch (error) {
                alert("Gagal menambahkan barang. Pastikan data benar.");
                console.error(error);
            }
        },
        openEditForm(item) {
            this.editForm = { ...item };
            this.showEditForm = true;
            this.showAddForm = false; // Hide add form if open
        },
        async updateItem() {
            try {
                await axios.put(`/api/items/${this.editForm.id}`, {
                    name: this.editForm.name,
                    unit: this.editForm.unit,
                    initial_stock: this.editForm.initial_stock,
                });
                this.showEditForm = false;
                this.fetchItems();
            } catch (error) {
                alert("Gagal mengupdate barang. Pastikan data benar.");
                console.error(error);
            }
        },
        async deleteItem(id) {
            if (confirm("Apakah Anda yakin ingin menghapus barang ini?")) {
                try {
                    await axios.delete(`/api/items/${id}`);
                    this.fetchItems();
                } catch (error) {
                    console.error(error);
                }
            }
        },
    },
};
</script>

<style scoped>
.slide-down-enter-active,
.slide-down-leave-active {
    transition: all 0.3s ease-out;
    transform-origin: top;
}
.slide-down-enter-from,
.slide-down-leave-to {
    opacity: 0;
    transform: translateY(-10px) scaleY(0.95);
}
</style>
