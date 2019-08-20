// Core dependecies
import { Microcart } from 'vue-storefront_1'

export default {
  methods: {
    closeMicrocart () {
      // Method renamed to 'toggleMicrocart'
      this.toggleMicrocart()
    }
  },
  computed: {
    isMicrocartOpen () {
      return this.$store.state.ui.microcart
    }
  },
  mixins: [
    Microcart
  ]
}
