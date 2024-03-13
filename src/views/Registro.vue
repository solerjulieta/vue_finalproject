<template>
    <v-container tag="section">
        <ComponenteRegistro />
    </v-container>
</template>

<script>
import ComponenteRegistro from '../components/Componente-registro';

export default {
    name: 'RegistroUsuario',
    components: {
        ComponenteRegistro
    },
}
</script>

<style scoped>
section{margin-top: 3rem;}
</style>