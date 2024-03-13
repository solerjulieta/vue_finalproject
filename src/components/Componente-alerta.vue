<template>
    <v-alert v-if="mostrar"
      :type="tipo"
      variant="outlined"
      border="top"
      id="alert"
      class="animate__animated animate__bounceInRight"
    >
      {{ mensaje }}
    </v-alert>
</template>

<script>
export default{
    name: 'ComponenteAlerta',
    props: {
        mostrar: Boolean,
        tipo: String,
        mensaje: String,
    },
    watch: {
        mostrar(nuevoValor){
            if(nuevoValor){
                this.iniciarTemporizador();
            }
        }
    },
    methods: {
        iniciarTemporizador(){
            setTimeout(() => {
                this.$emit('cerrar');
            }, 5000);
        }
    }
}
</script>

<style scoped>
#alert{
    position: fixed;
    right: 3px;
    z-index: 1;
}
</style>