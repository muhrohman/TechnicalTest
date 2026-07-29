<template>
  <div class="space-y-6 text-black">
    <!-- Header & Filter Section -->
    <div class="bg-white p-6 border-2 border-black">
      <div class="flex flex-col md:flex-row md:justify-between md:items-end gap-6">
        <div>
          <h2 class="text-3xl font-black uppercase tracking-tight">Laporan Stok Akhir</h2>
          <p class="text-sm font-medium mt-1">Pantau pergerakan stok berdasarkan rentang waktu tertentu.</p>
        </div>
        
        <div class="flex flex-col sm:flex-row gap-4 items-end p-4 border-2 border-black">
          <div>
            <label class="block text-xs font-bold uppercase tracking-wider mb-1.5">Mulai Tanggal</label>
            <VueDatePicker v-model="filters.start_date" :enable-time-picker="false" auto-apply format="yyyy-MM-dd" input-class-name="dp-custom-input" hide-input-icon />
          </div>
          <div>
            <label class="block text-xs font-bold uppercase tracking-wider mb-1.5">Sampai Tanggal</label>
            <VueDatePicker v-model="filters.end_date" :enable-time-picker="false" auto-apply format="yyyy-MM-dd" input-class-name="dp-custom-input" hide-input-icon />
          </div>
          <div class="flex space-x-2">
            <button @click="fetchReports" class="bg-black text-white hover:bg-white hover:text-black border-2 border-black font-bold py-2.5 px-5 transition-colors flex items-center">
              <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2.586a1 1 0 01-.293.707l-6.414 6.414a1 1 0 00-.293.707V17l-4 4v-6.586a1 1 0 00-.293-.707L3.293 7.293A1 1 0 013 6.586V4z"></path></svg>
              FILTER
            </button>
            <button @click="resetFilter" class="bg-white text-black hover:bg-gray-100 border-2 border-black font-bold py-2.5 px-5 transition-colors">
              RESET
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Table Section -->
    <div class="bg-white border-2 border-black overflow-hidden">
      <div class="overflow-x-auto">
        <table class="min-w-full divide-y-2 divide-black">
          <thead class="bg-black text-white">
            <tr>
              <th scope="col" class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider border-r border-gray-700">Barang</th>
              <th scope="col" class="px-6 py-4 text-center text-sm font-bold uppercase tracking-wider border-r border-gray-700">Stok Awal</th>
              <th scope="col" class="px-6 py-4 text-center text-sm font-bold uppercase tracking-wider border-r border-gray-700">Total Masuk</th>
              <th scope="col" class="px-6 py-4 text-center text-sm font-bold uppercase tracking-wider border-r border-gray-700">Total Keluar</th>
              <th scope="col" class="px-6 py-4 text-right text-sm font-bold uppercase tracking-wider">Stok Akhir</th>
            </tr>
          </thead>
          <tbody class="divide-y-2 divide-black bg-white">
            <tr v-for="item in reports" :key="item.id" class="hover:bg-gray-100 transition-colors">
              <td class="px-6 py-4 whitespace-nowrap border-r border-black">
                <div class="text-sm font-bold">{{ item.name }}</div>
                <div class="text-xs font-mono mt-0.5">{{ item.item_code }}</div>
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-center border-r border-black">
                <span class="text-lg font-black">{{ item.initial_stock }}</span>
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-center border-r border-black">
                <span class="inline-flex items-center px-3 py-1 border-2 border-black text-xs font-black uppercase tracking-widest bg-green-500 text-white">
                  +{{ item.total_in }}
                </span>
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-center border-r border-black">
                <span class="inline-flex items-center px-3 py-1 border-2 border-black text-xs font-black uppercase tracking-widest bg-red-500 text-white">
                  -{{ item.total_out }}
                </span>
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-right">
                <div class="flex flex-col items-end">
                  <span class="text-2xl font-black">{{ item.final_stock }}</span>
                  <span class="text-xs font-bold uppercase">{{ item.unit }}</span>
                </div>
              </td>
            </tr>
            <tr v-if="reports.length === 0">
              <td colspan="5" class="px-6 py-12 text-center border-t-2 border-black">
                <div class="flex flex-col items-center justify-center text-black">
                  <svg class="w-12 h-12 mb-3" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M9 17v-2m3 2v-4m3 4v-6m2 10H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path></svg>
                  <span class="text-sm font-bold uppercase tracking-wider">Tidak ada data untuk laporan ini.</span>
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
import { VueDatePicker } from '@vuepic/vue-datepicker';
import '@vuepic/vue-datepicker/dist/main.css';

export default {
  components: { VueDatePicker },
  data() {
    return {
      reports: [],
      filters: {
        start_date: '',
        end_date: ''
      }
    }
  },
  mounted() {
    this.fetchReports();
  },
  methods: {
    async fetchReports() {
      // format dates before sending
      const params = { ...this.filters };
      if (params.start_date instanceof Date) {
        params.start_date = params.start_date.toISOString().split('T')[0];
      }
      if (params.end_date instanceof Date) {
        params.end_date = params.end_date.toISOString().split('T')[0];
      }
      try {
        const response = await axios.get('/api/reports', { params: params });
        this.reports = response.data;
      } catch (error) {
        console.error("Error fetching reports:", error);
      }
    },
    resetFilter() {
      this.filters = { start_date: '', end_date: '' };
      this.fetchReports();
    }
  }
}
</script>
