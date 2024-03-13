<template>
    <v-container tag="section">
        <ComponenteAlerta
            :mostrar="mostrarAlerta"
            :tipo="tipoAlerta"
            :mensaje="mensajeAlerta"
            @cerrar="mostrarAlerta = false"
        />
        <ComponenteLogin />
    </v-container>
</template>

<script>
import ComponenteLogin from '../components/Componente-login';
import ComponenteAlerta from '../components/Componente-alerta';

export default {
    name: 'IniciarSesion',
    components: {
        ComponenteLogin,
        ComponenteAlerta
    },
    data: function(){
        return{
            registroExitoso: false,
            mostrarAlerta: false,
            tipoAlerta: '',
            mensajeAlerta: '',
        }
    },
    mounted: function(){
        let params = new URLSearchParams(this.$route.query);
        this.registroExitoso = params.get('registroExitoso') === 'true';
        if(this.registroExitoso){
            this.mostrarAlerta = true;
            this.tipoAlerta = 'success';
            this.mensajeAlerta = 'Registro exitoso. ¡Ya podés iniciar sesión!';
        }
    }
}
</script>

<style scoped>
section{margin-top: 3rem;}
#alert{max-width: 300px;}
</style>