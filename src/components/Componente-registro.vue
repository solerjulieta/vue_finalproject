<template>
    <v-container tag="section" class="espacio">
    <ComponenteAlerta
        :mostrar="mostrarAlerta"
        :tipo="tipoAlerta"
        :mensaje="mensajeAlerta"
        @cerrar="mostrarAlerta = false"
    />
    <h2>Registrarse</h2>
    <v-row>
    <v-col :cols="12" :lg="6" :xl="4">
    <v-form v-on:submit.prevent="enviar" novalidate>
        <v-text-field
            label="Nombre"
            v-model.trim="usuario.nombre"
        >
        </v-text-field>
        <span v-show="enviado===true && !usuario.nombre"><svg-icon type="mdi" :path="path"></svg-icon>El nombre es requerido.</span>
        <v-text-field
            label="Email"
            type="email"
            v-model.trim="usuario.email"
        >
        </v-text-field>
        <span v-show="enviado===true && !usuario.email"><svg-icon type="mdi" :path="path"></svg-icon>El email es requerido.</span>
        <v-text-field
            label="Contraseña"
            type="password"
            v-model.trim="usuario.password"
        >
        </v-text-field>
        <span v-show="enviado===true && !usuario.password"><svg-icon type="mdi" :path="path"></svg-icon>La contraseña es requerida.</span>
        <v-btn
            color="primary"
            type="submit"
            class="btnSubmit"
        >
        Registrarme
        </v-btn>
    </v-form>
</v-col>
    </v-row>
    </v-container>
</template>

<script>
import SvgIcon from '@jamescoyle/vue-icon';
import { mdiAlertCircle } from '@mdi/js';
import ComponenteAlerta from './Componente-alerta';

export default{
    name: 'ComponenteRegistro',
    components:{
        SvgIcon,
        ComponenteAlerta,
    },
    data: function(){
        return{
            usuario:{
                nombre: "",
                email: "",
                password: ""
            },
            enviado: false,
            path: mdiAlertCircle,
            mostrarAlerta: false,
            tipoAlerta: '',
            mensajeAlerta: '',
        }
    },
    methods: {
        enviar: function(){
            this.enviado = true;
            if(this.usuario.nombre && this.usuario.email && this.usuario.password){
                this.registrar(this.usuario);
            } else {
                this.mostrarAlerta = true;
                this.tipoAlerta = 'error';
                this.mensajeAlerta = "Completá todos los campos."
            }
        },
        registrar:function(usuario){
            let nuevoUsuario = new FormData();
            for(let x in usuario){
                nuevoUsuario.append(x, usuario[x]);
            }

            fetch('http://finalibroteca.000webhostapp.com/app/registro.php',{
                method: 'POST',
                body: nuevoUsuario,
            })
            .then(response => response.json())
            .then(data => {
                console.log(data);
                this.$router.push({path: '/iniciar-sesion', query: {registroExitoso: true}});
            })
            .catch(error => {
                console.error('Error en la solicitud:', error);
                this.mostrarAlerta = true;
                this.tipoAlerta = 'error';
                this.mensajeAlerta = "Ocurrió un error al intentar registrarte."
            });
        }
    }
}
</script>
<style scoped>
  span{
    color: red;
    font-size: .8rem;
    margin-right: 2rem;
    display: flex;
    align-items: center;
  }

  svg{
    width: 18px;
    height: 18px;
  }

  #alert{
    top: 100px;
    max-width: 300px;
   }

   h2{margin-bottom: 3rem;}

  @media screen and (min-width: 1280px){
    .espacio{margin-left: 10rem;}
   }
</style>