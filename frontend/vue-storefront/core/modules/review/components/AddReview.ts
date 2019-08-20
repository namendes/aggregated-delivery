import Review from 'vue-storefront_1'

export const AddReview = {
  name: 'AddReview',
  methods: {
    addReview (review: Review) {
      this.$store.dispatch('review/add', review)
    }
  }
}
