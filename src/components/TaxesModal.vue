<template>
  <div class="modal__wrapper">
    <div class="modal__background" @click="closeModal"></div>
    <div class="modal__content-wrapper">
      <form action="" class="modal__content">
        <h1 class="modal__title">Налоговый вычет</h1>
        <p class="modal__descr">
          Используйте налоговый вычет чтобы погасить ипотеку досрочно. Размер
          налогового вычета составляет не более 13% от своего официального
          годового дохода.
        </p>
        <div class="modal__input">
          <p class="modal__salary">Ваша зарплата в месяц</p>
          <input
            class="modal__salary-data"
            type="number"
            placeholder="Введите данные"
            v-model="input"
          />
          <button class="modal__count" type="button" @click="count">
            Рассчитать
          </button>
        </div>
        <div class="modal__counted" v-if="isCountedActive">
          <p class="modal__counted-descr">
            Итого можете внести в качестве досрочных:
          </p>
          <div
            class="modal__checkbox-wrapper"
            v-for="(deduction, index) in deductions"
            :key="index"
          >
            <input
              class="modal__checkbox"
              type="checkbox"
              :id="index"
              :value="deduction"
            />
            <label class="modal__label" :for="index">{{ deduction }} в {{ index + 1 }} год</label>
          </div>
        </div>
        <button class="modal__add" type="submit">Добавить</button>
        <img
          src="../../src/assets/close.svg"
          class="modal__close"
          @click="closeModal"
        />
      </form>
    </div>
  </div>
</template>

<script>
const LIMIT = 260000;

export default {
  name: "TaxesModal",

  data() {
    return {
      input: "",
      salary: 0,
      percent: 0,
      years: 0,
      remainder: 0,
      deductions: [],
      isCountedActive: false,
    };
  },

  methods: {
    count() {
      if (this.input !== "") {
        this.salary = +this.input;
        this.percent = +(this.salary * 12 * 0.13).toFixed();
        this.years = Math.ceil(LIMIT / this.percent);
        this.remainder = LIMIT % this.percent;
        this.deductions = this.createDeductions(this.years);
        this.isCountedActive = true;
      }
    },

    createDeductions(years) {
      const array = [];
      for (let i = 0; i < years - 1; i++) {
        array[i] = this.percent;
      }
      if (this.remainder) {
        array.push(this.remainder);
      }
      return array;
    },

    closeModal() {
      this.$emit("closeModal");
    },
  },
};
</script>
<style scoped lang="scss">
@import "/src/styles/TaxesModal.scss" 
</style>
