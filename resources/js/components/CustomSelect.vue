<template>
  <div class="relative w-full text-black">
    <div v-if="isOpen" @click="isOpen = false" class="fixed inset-0 z-40"></div>
    <div 
      @click="isOpen = !isOpen" 
      class="relative z-50 flex items-center justify-between w-full border-2 border-black bg-white focus:outline-none text-sm py-3 px-4 font-medium transition-colors cursor-pointer select-none"
    >
      <span :class="{'text-black font-bold uppercase': selectedLabel, 'text-gray-500 font-bold uppercase': !selectedLabel}">
        {{ selectedLabel || placeholder }}
      </span>
      <svg class="w-5 h-5 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M19 9l-7 7-7-7"></path></svg>
    </div>
    
    <div v-if="isOpen" class="absolute z-50 w-full mt-1 border-2 border-black bg-white max-h-60 overflow-y-auto">
      <div 
        v-if="options.length === 0" 
        class="px-4 py-3 text-sm text-gray-500 uppercase font-bold"
      >
        Tidak ada pilihan
      </div>
      <div 
        v-for="option in options" 
        :key="option.value"
        @click="selectOption(option)"
        class="px-4 py-3 text-sm font-bold uppercase cursor-pointer transition-colors border-b last:border-b-0 border-black"
        :class="modelValue === option.value ? 'bg-black text-white' : 'hover:bg-black hover:text-white'"
      >
        {{ option.label }}
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'CustomSelect',
  props: {
    modelValue: { type: [String, Number], default: '' },
    options: { type: Array, default: () => [] },
    placeholder: { type: String, default: 'Pilih...' }
  },
  emits: ['update:modelValue', 'change'],
  data() {
    return { isOpen: false }
  },
  computed: {
    selectedLabel() {
      const opt = this.options.find(o => o.value === this.modelValue);
      return opt ? opt.label : '';
    }
  },
  methods: {
    selectOption(option) {
      this.$emit('update:modelValue', option.value);
      this.$emit('change', option.value);
      this.isOpen = false;
    }
  }
}
</script>
