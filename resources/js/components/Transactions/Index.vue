<template>
  <div class="space-y-6 text-black">
    <!-- Header Section -->
    <div class="flex flex-col sm:flex-row sm:justify-between sm:items-center bg-white p-6 border-2 border-black">
      <div class="mb-4 sm:mb-0">
        <h2 class="text-3xl font-black uppercase tracking-tight">Transaksi Barang</h2>
        <p class="text-sm font-medium mt-1">Catat aktivitas barang masuk dan keluar dengan akurat.</p>
      </div>
      <div class="flex space-x-4">
        <button @click="openForm('in')" class="bg-black text-white hover:bg-white hover:text-black border-2 border-black font-bold py-3 px-6 transition-colors duration-200 flex items-center space-x-2">
          <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 11l5-5m0 0l5 5m-5-5v12"></path></svg>
          <span class="uppercase tracking-wider text-sm">Barang Masuk</span>
        </button>
        <button @click="openForm('out')" class="bg-white text-black hover:bg-black hover:text-white border-2 border-black font-bold py-3 px-6 transition-colors duration-200 flex items-center space-x-2">
          <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 13l-5 5m0 0l-5-5m5 5V6"></path></svg>
          <span class="uppercase tracking-wider text-sm">Barang Keluar</span>
        </button>
      </div>
    </div>

    <!-- Form Section -->
    <transition name="slide-down">
      <div v-if="showForm" class="bg-white p-8 border-2 border-black relative">
        <h3 class="text-xl font-black mb-6 uppercase flex items-center">
          <span class="bg-black text-white p-1 mr-3">
             <svg v-if="form.type==='in'" class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 11l5-5m0 0l5 5m-5-5v12"></path></svg>
             <svg v-else class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 13l-5 5m0 0l-5-5m5 5V6"></path></svg>
          </span>
          Catat Barang {{ form.type === 'in' ? 'Masuk' : 'Keluar' }}
        </h3>
        
        <form @submit.prevent="submitTransaction">
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label class="block text-sm font-bold uppercase tracking-wider mb-2">Pilih Barang</label>
              <CustomSelect v-model="form.item_id" :options="itemOptions" placeholder="Pilih Barang..." />
            </div>
            <div>
              <label class="block text-sm font-bold uppercase tracking-wider mb-2">Tanggal</label>
              <VueDatePicker v-model="form.transaction_date" :enable-time-picker="false" auto-apply format="yyyy-MM-dd" input-class-name="dp-custom-input" hide-input-icon />
            </div>
            <div>
              <label class="block text-sm font-bold uppercase tracking-wider mb-2">Jumlah {{ form.type === 'in' ? 'Masuk' : 'Keluar' }}</label>
              <input v-model="form.quantity" type="number" required min="1" class="block w-full border-2 border-black bg-white focus:ring-0 focus:outline-none text-sm py-3 px-4 font-medium transition-colors">
            </div>
            <div>
              <label class="block text-sm font-bold uppercase tracking-wider mb-2">Keterangan (Opsional)</label>
              <input v-model="form.description" type="text" placeholder="Catatan transaksi..." class="block w-full border-2 border-black bg-white focus:ring-0 focus:outline-none text-sm py-3 px-4 font-medium transition-colors">
            </div>
          </div>
          <div class="mt-8 flex justify-end space-x-4">
            <button type="button" @click="showForm = false" class="bg-white border-2 border-black hover:bg-gray-100 text-black font-bold py-3 px-8 uppercase tracking-wider text-sm transition-colors">Batal</button>
            <button type="submit" class="bg-black hover:bg-white hover:text-black border-2 border-black text-white font-bold py-3 px-10 uppercase tracking-wider text-sm transition-colors">Simpan Transaksi</button>
          </div>
        </form>
      </div>
    </transition>

    <!-- Table Section -->
    <div class="bg-white border-2 border-black overflow-hidden">
      <div class="overflow-x-auto">
        <table class="min-w-full divide-y-2 divide-black">
          <thead class="bg-black text-white">
            <tr>
              <th scope="col" class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider border-r border-gray-700">Tanggal</th>
              <th scope="col" class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider border-r border-gray-700">Tipe</th>
              <th scope="col" class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider border-r border-gray-700">Barang</th>
              <th scope="col" class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider border-r border-gray-700">Jumlah</th>
              <th scope="col" class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">Keterangan</th>
            </tr>
          </thead>
          <tbody class="divide-y-2 divide-black bg-white">
            <tr v-for="t in transactions" :key="t.id" class="hover:bg-gray-100 transition-colors">
              <td class="px-6 py-4 whitespace-nowrap text-sm font-bold border-r border-black">{{ t.transaction_date }}</td>
              <td class="px-6 py-4 whitespace-nowrap border-r border-black">
                <span v-if="t.type === 'in'" class="inline-flex items-center px-3 py-1 border-2 border-black text-xs font-black bg-green-500 text-white uppercase tracking-widest">Masuk</span>
                <span v-else class="inline-flex items-center px-3 py-1 border-2 border-black text-xs font-black bg-red-500 text-white uppercase tracking-widest">Keluar</span>
              </td>
              <td class="px-6 py-4 whitespace-nowrap border-r border-black">
                <div class="text-sm font-bold">{{ t.item.name }}</div>
                <div class="text-xs font-mono mt-0.5">{{ t.item.item_code }}</div>
              </td>
              <td class="px-6 py-4 whitespace-nowrap border-r border-black">
                <span class="text-xl font-black" :class="t.type === 'in' ? 'text-green-600' : 'text-red-600'">
                  {{ t.type === 'in' ? '+' : '-' }}{{ t.quantity }} <span class="font-bold text-xs ml-1 uppercase text-black">{{ t.item.unit }}</span>
                </span>
              </td>
              <td class="px-6 py-4 text-sm font-medium italic max-w-xs truncate">{{ t.description || '-' }}</td>
            </tr>
            <tr v-if="transactions.length === 0">
              <td colspan="5" class="px-6 py-12 text-center border-t-2 border-black">
                <div class="flex flex-col items-center justify-center text-black">
                  <svg class="w-12 h-12 mb-3" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"></path></svg>
                  <span class="text-sm font-bold uppercase tracking-wider">Belum ada data transaksi.</span>
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
import axios from 'axios';
import CustomSelect from '../CustomSelect.vue';
import { VueDatePicker } from '@vuepic/vue-datepicker';
import '@vuepic/vue-datepicker/dist/main.css';

export default {
  components: { CustomSelect, VueDatePicker },
  data() {
    return {
      transactions: [],
      items: [],
      showForm: false,
      form: {
        item_id: '',
        type: 'in',
        transaction_date: new Date().toISOString().split('T')[0],
        quantity: 1,
        description: ''
      }
    }
  },
  computed: {
    itemOptions() {
      return this.items.map(i => ({ value: i.id, label: `${i.item_code} - ${i.name} (Stok: ${i.final_stock})` }));
    }
  },
  mounted() {
    this.fetchTransactions();
    this.fetchItems();
  },
  methods: {
    async fetchTransactions() {
      try {
        const response = await axios.get('/api/transactions');
        this.transactions = response.data.sort((a,b) => new Date(b.created_at) - new Date(a.created_at));
      } catch (error) {
        console.error("Error fetching transactions:", error);
      }
    },
    async fetchItems() {
      try {
        const response = await axios.get('/api/items');
        this.items = response.data;
      } catch (error) {
        console.error("Error fetching items:", error);
      }
    },
    openForm(type) {
      this.form.type = type;
      this.form.item_id = '';
      this.form.quantity = 1;
      this.form.description = '';
      this.form.transaction_date = new Date().toISOString().split('T')[0];
      this.showForm = true;
    },
    async submitTransaction() {
      if (this.form.type === 'out') {
        const item = this.items.find(i => i.id === this.form.item_id);
        if (item && this.form.quantity > item.final_stock) {
          alert('Error: Jumlah keluar melebihi stok yang tersedia!');
          return;
        }
      }

      const payload = {
        ...this.form,
        transaction_date: this.form.transaction_date instanceof Date ? this.form.transaction_date.toISOString().split('T')[0] : this.form.transaction_date
      };

      try {
        await axios.post('/api/transactions', payload);
        this.showForm = false;
        this.fetchTransactions();
        this.fetchItems(); // update stock info
      } catch (error) {
        console.error(error);
        alert('Terjadi kesalahan saat menyimpan transaksi.');
      }
    }
  }
}
</script>

<style>
/* Global Datepicker overrides for monochrome brutalist style */
.dp-custom-input {
  border: 2px solid black !important;
  border-radius: 0 !important;
  font-family: 'Plus Jakarta Sans', sans-serif !important;
  font-size: 0.875rem !important;
  font-weight: 700 !important;
  padding: 0.75rem 1rem !important;
  background-color: white !important;
  color: black !important;
}

:root {
  --dp-background-color: #fff;
  --dp-text-color: #000;
  --dp-hover-color: #000;
  --dp-hover-text-color: #fff;
  --dp-hover-icon-color: #fff;
  --dp-primary-color: #000;
  --dp-primary-disabled-color: #ccc;
  --dp-primary-text-color: #fff;
  --dp-secondary-color: #000;
  --dp-border-color: #000;
  --dp-menu-border-color: #000;
  --dp-border-color-hover: #000;
  --dp-border-color-focus: #000;
  --dp-border-radius: 0px;
  --dp-font-family: 'Plus Jakarta Sans', sans-serif;
  --dp-action-button-height: 35px;
}
.dp__theme_light {
  --dp-background-color: #ffffff;
  --dp-text-color: #000000;
  --dp-border-color: #000000;
}
.dp__menu {
  border: 2px solid black !important;
  box-shadow: none !important;
}
.dp__cell_inner {
  border-radius: 0 !important;
  font-weight: 700;
}
.dp__active_date {
  background-color: black !important;
  color: white !important;
  border: 1px solid black !important;
}
</style>
<style scoped>
.slide-down-enter-active,
.slide-down-leave-active {
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  transform-origin: top;
}
.slide-down-enter-from,
.slide-down-leave-to {
  opacity: 0;
  transform: translateY(-10px) scaleY(0.95);
}
</style>
