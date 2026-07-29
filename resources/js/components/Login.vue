<template>
  <div class="min-h-screen bg-white flex items-center justify-center p-6 text-black font-['Plus_Jakarta_Sans']">
    <div class="w-full max-w-md border-4 border-black p-8 bg-white shadow-[8px_8px_0px_0px_rgba(0,0,0,1)] relative">
      <div class="absolute -top-6 -left-6 bg-black text-white px-4 py-2 font-black text-xl tracking-widest border-2 border-black">
        LOGIN
      </div>
      
      <div class="mt-8 mb-8 text-center">
        <h1 class="text-4xl font-black uppercase tracking-tighter mb-2">Sistem Stok</h1>
        <p class="font-bold text-sm uppercase tracking-widest">Akses Terbatas</p>
      </div>

      <div v-if="error" class="mb-6 p-4 bg-red-500 text-white font-bold border-2 border-black text-sm uppercase tracking-wider">
        {{ error }}
      </div>

      <form @submit.prevent="handleLogin" class="space-y-6">
        <div>
          <label class="block text-sm font-black uppercase tracking-wider mb-2">Username</label>
          <input 
            v-model="form.username" 
            type="text" 
            required 
            placeholder="admin"
            class="block w-full border-4 border-black bg-white focus:ring-0 focus:outline-none text-lg py-3 px-4 font-bold transition-all focus:translate-x-1 focus:-translate-y-1 focus:shadow-[-4px_4px_0px_0px_rgba(0,0,0,1)]"
          >
        </div>
        
        <div>
          <label class="block text-sm font-black uppercase tracking-wider mb-2">Password</label>
          <input 
            v-model="form.password" 
            type="password" 
            required 
            placeholder="••••••••"
            class="block w-full border-4 border-black bg-white focus:ring-0 focus:outline-none text-lg py-3 px-4 font-bold transition-all focus:translate-x-1 focus:-translate-y-1 focus:shadow-[-4px_4px_0px_0px_rgba(0,0,0,1)]"
          >
        </div>

        <button 
          type="submit" 
          :disabled="loading"
          class="w-full bg-black hover:bg-white hover:text-black text-white border-4 border-black font-black py-4 px-6 text-xl uppercase tracking-widest transition-colors duration-200 mt-8 disabled:opacity-50"
        >
          {{ loading ? 'LOADING...' : 'MASUK' }}
        </button>
      </form>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      form: {
        username: '',
        password: ''
      },
      error: '',
      loading: false
    }
  },
  methods: {
    async handleLogin() {
      this.error = '';
      this.loading = true;
      
      try {
        // Since we are using session auth, we need to grab the CSRF cookie first (if we haven't already on initial load)
        await axios.get('/sanctum/csrf-cookie');
        
        await axios.post('/api/login', this.form);
        
        // After successful login, set a flag in localStorage so the app knows we are logged in
        localStorage.setItem('isLoggedIn', 'true');
        
        // Redirect to dashboard
        this.$router.push('/');
      } catch (err) {
        if (err.response && err.response.status === 401) {
          this.error = 'Username atau Password salah!';
        } else {
          this.error = 'Terjadi kesalahan pada server.';
        }
      } finally {
        this.loading = false;
      }
    }
  }
}
</script>
