<template>
  <div class="modal__wrapper">
    <div class="modal__background" @click="closeModal"></div>
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
            value="deduction"
          />
          <label :for="index">{{ deduction }} в {{ index + 1 }} год</label>
        </div>
      </div>
      <button class="modal__add" type="submit">Добавить</button>
      <img
        src="../../src/assets/close.png"
        class="modal__close"
        @click="closeModal"
      />
    </form>
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
.modal {
  &__background {
    z-index: 98;
    position: fixed;
    top: 0;
    width: 100vw;
    height: 100vh;
    background: grey;
  }

  &__content {
    z-index: 99;
    position: absolute;
    top: 120px;
    left: 50%;
    margin-left: -276px;
    padding: 32px;
    width: 552px;
    display: flex;
    flex-direction: column;
    align-items: left;
    text-align: left;
    background-color: #fff;
    border-radius: 30px;
  }

  &__title {
    margin-bottom: 16px;
    font-weight: 500;
    font-size: 28px;
    line-height: 40px;
  }

  &__descr {
    margin-bottom: 24px;
    font-weight: normal;
    font-size: 14px;
    line-height: 24px;
    color: #808080;
  }

  &__salary {
    margin-bottom: 8px;
    font-weight: 500;
    font-size: 14px;
    line-height: 24px;
  }

  &__count {
    margin-bottom: 8px;
    background: none;
    border: none;
    color: #ea0029;
    cursor: pointer;
    font-weight: 500;
    font-size: 14px;
    line-height: 24px;
    align-self: start;
  }

  &__input {
    display: flex;
    flex-direction: column;
    align-items: left;
  }

  &__salary-data {
    padding: 8px 10px;
    margin-bottom: 8px;
    font-weight: normal;
    font-size: 14px;
    line-height: 24px;
  }

  &__counted {
    margin-bottom: 48px;
  }

  &__counted-descr {
    margin-bottom: 16px;
    font-weight: 500;
    font-size: 14px;
    line-height: 24px;
  }

  &__checkbox-wrapper {
    margin-bottom: 18px;
    border-bottom: 1px #dfe3e6 solid;
  }

  &__checkbox {
    margin-right: 11px;
  }

  &__add {
    width: 488px;
    height: 56px;
    background: linear-gradient(
        255.35deg,
        #dc3131 0.83%,
        rgba(255, 79, 79, 0) 108.93%
      ),
      #ff5e56;
    box-shadow: 0px 0px 24px rgba(234, 0, 41, 0.33);
    border: none;
    border-radius: 6px;
    font-weight: 500;
    font-size: 16px;
    line-height: 24px;
    color: #fff;
  }

  &__close {
    position: absolute;
    top: 27px;
    right: 27px;
    height: 18px;
    width: 18px;
    cursor: pointer;
  }
}
</style>
