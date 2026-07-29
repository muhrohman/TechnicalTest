<template>
    <div
        class="min-h-screen bg-slate-50 font-sans text-black p-4 md:p-8 relative"
    >
        <!-- Logout Button -->
        <button
            v-if="isLoggedIn && $route.name !== 'login'"
            @click="handleLogout"
            class="absolute top-4 right-4 md:top-8 md:right-8 bg-red-500 hover:bg-black text-white border-2 border-black font-black px-4 py-2 text-xs uppercase tracking-widest transition-colors z-50"
        >
            Logout
        </button>

        <div class="max-w-7xl mx-auto space-y-8 mt-12 md:mt-0">
            <!-- In-Page Navigation Menu -->
            <nav
                v-if="isLoggedIn && $route.name !== 'login'"
                class="flex flex-col sm:flex-row gap-4"
            >
                <router-link
                    to="/"
                    class="flex-1 text-center px-6 py-4 text-sm font-black border-2 border-black bg-white hover:bg-black hover:text-white transition-colors uppercase tracking-widest"
                    active-class="!bg-black !text-white shadow-[4px_4px_0px_0px_rgba(0,0,0,1)] -translate-y-1"
                >
                    MASTER BARANG
                </router-link>
                <router-link
                    to="/transactions"
                    class="flex-1 text-center px-6 py-4 text-sm font-black border-2 border-black bg-white hover:bg-black hover:text-white transition-colors uppercase tracking-widest"
                    active-class="!bg-black !text-white shadow-[4px_4px_0px_0px_rgba(0,0,0,1)] -translate-y-1"
                >
                    TRANSAKSI
                </router-link>
                <router-link
                    to="/reports"
                    class="flex-1 text-center px-6 py-4 text-sm font-black border-2 border-black bg-white hover:bg-black hover:text-white transition-colors uppercase tracking-widest"
                    active-class="!bg-black !text-white shadow-[4px_4px_0px_0px_rgba(0,0,0,1)] -translate-y-1"
                >
                    LAPORAN STOK
                </router-link>
            </nav>

            <!-- Main Content Area -->
            <main>
                <router-view v-slot="{ Component }">
                    <transition name="fade" mode="out-in">
                        <component :is="Component" />
                    </transition>
                </router-view>
            </main>
        </div>
    </div>
</template>

<script>
import axios from "axios";

export default {
    name: "App",
    data() {
        return {
            isLoggedIn: localStorage.getItem("isLoggedIn") === "true",
        };
    },
    watch: {
        $route() {
            this.isLoggedIn = localStorage.getItem("isLoggedIn") === "true";
        },
    },
    methods: {
        async handleLogout() {
            try {
                await axios.post("/api/logout");
            } catch (e) {
                console.error(e);
            } finally {
                localStorage.removeItem("isLoggedIn");
                this.$router.push("/login");
            }
        },
    },
};
</script>

<style>
.fade-enter-active,
.fade-leave-active {
    transition:
        opacity 0.3s ease,
        transform 0.3s ease;
}

.fade-enter-from {
    opacity: 0;
    transform: translateY(10px);
}
.fade-leave-to {
    opacity: 0;
    transform: translateY(-10px);
}
</style>
