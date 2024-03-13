<template>
    <v-dialog v-model="dialog" max-width="500px">
      <v-card>
        <div id="card-titulo">
          <h2 class="headline">¿Estás seguro/a que deseas eliminar tu reseña?</h2>
        </div>
  
        <v-card-text>
          Estás a punto de eliminar tu comentario. Recordá que esto es irreversible.
        </v-card-text>
  
        <v-card-actions>
          <v-btn color="primary" @click="cerrarModal">Cerrar</v-btn>
          <v-btn color="error" @click="confirmar">Confirmar</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
</template>

<script>
export default {
  name: 'ComponenteModal',
  props: ['reseniaSeleccionada', 'resenia', 'eliminar'],    
  data: function() {
    return {
      dialog: false,
    };
  },
  methods: {
    abrirModal() {
      this.dialog = true;
    },
    cerrarModal() {
      this.dialog = false;
    },
    confirmar(){
      this.$emit('eliminar-resenia');
      this.dialog = false;
    }
  },
};
</script>

<style scoped>
#card-titulo{padding: 16px 24px 10px;}
</style>
