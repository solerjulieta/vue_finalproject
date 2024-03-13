<template>
    <v-container tag="section" class="espacio">
    <ComponenteAlerta
        :mostrar="mostrarAlerta"
        :tipo="tipoAlerta"
        :mensaje="mensajeAlerta"
        @cerrar="mostrarAlerta = false"
    />
    <h2>Iniciar Sesión</h2>
    <v-row>
    <v-col :cols="12" :lg="6" :xl="4">
    <v-form v-on:submit.prevent="enviar" novalidate>
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
        Iniciar sesión
        </v-btn>
    </v-form>
    </v-col>
    </v-row>
</v-container>
</template>

<script>
import ComponenteAlerta from './Componente-alerta';
import SvgIcon from '@jamescoyle/vue-icon';
import { mdiAlertCircle } from '@mdi/js';

export default{
    name: 'ComponenteLogin',
    components:{
        SvgIcon,
        ComponenteAlerta,
    },
    data: function(){
        return{
            usuario: {
                email: "",
                password: "",
            },
            enviado: false,
            path: mdiAlertCircle,
            mostrarAlerta: false,
            tipoAlerta: '',
            mensajeAlerta: '',
        }
    },
    methods:{
        enviar:function(){
            this.enviado = true;
            if(this.usuario.email && this.usuario.password){
                this.login(this.usuario);
            } else {
                this.mostrarAlerta = true;
                this.tipoAlerta = 'error';
                this.mensajeAlerta = "Completá todos los campos."
            }
        },
        login:function(){
            let loginUsuario = new FormData();
            for(let x in this.usuario){
                loginUsuario.append(x, this.usuario[x]);
            }

            if(this.usuario.email && this.usuario.password){
                fetch('http://finalibroteca.000webhostapp.com/app/login.php', {
                    method: 'POST',
                    body: loginUsuario,
                })
                .then(response => response.json())
                .then(data => {
                    if('error' in data){
                        this.mostrarAlerta = true;
                        this.tipoAlerta = 'error';
                        this.mensajeAlerta = data.error;
                    } else if ('token' in data && 'usuario_id' in data) {
                        localStorage.setItem('authData', JSON.stringify({ token: data.token, usuario: data.usuario_id }));

                        this.$router.push({path: '/', query: {loginExitoso: true}});
                    }
                })
                .catch(error => {
                    console.log('Error en la solicitud:', error);
                    this.mostrarAlerta = true;
                    this.tipoAlerta = 'error';
                    this.mensajeAlerta = "Ocurrió un error al intentar loguearte."
                })
            }
        }
    },
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