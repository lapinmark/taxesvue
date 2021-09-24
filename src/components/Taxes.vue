<template>
  <div class="taxes__container">
    <button class="taxes__open-modal" type="button" @click="activateModal">
      Налоговый вычет
    </button>
  </div>
  <TaxesModal v-if="isModalActive" @closeModal="closeModal" />
</template>

<script>
import TaxesModal from "./TaxesModal.vue";

export default {
  name: "Taxes",

  components: {
    TaxesModal,
  },

  data() {
    return {
      isModalActive: false,
    };
  },

  methods: {
    activateModal() {
      this.isModalActive = true;
    },

    closeModal() {
      this.isModalActive = false;
    },
  },
};
</script>

<style scoped lang="scss">
.taxes__container {
  width: 100vw;
  height: 100vh;
  background: linear-gradient(
      255.35deg,
      #dc3131 0.83%,
      rgba(255, 79, 79, 0) 108.93%
    ),
    #ff5e56;
  display: flex;
  align-items: center;
  justify-content: center;
}

.taxes__open-modal {
  width: 198px;
  height: 56px;
  cursor: pointer;
  background: transparent;
  border: #fff 1px solid;
  border-radius: 6px;
  font-weight: 500;
  font-size: 16px;
  line-height: 24px;
  color: #fff;
}
</style>
