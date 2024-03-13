-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 18-12-2023 a las 03:34:24
-- Versión del servidor: 10.5.20-MariaDB
-- Versión de PHP: 7.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `id21572320_libroteca`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `favoritos`
--

CREATE TABLE `favoritos` (
  `libro_id` int(10) UNSIGNED NOT NULL,
  `usuario_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `libros`
--

CREATE TABLE `libros` (
  `libro_id` int(10) UNSIGNED NOT NULL,
  `titulo` varchar(50) NOT NULL,
  `autor` varchar(50) NOT NULL,
  `imagen` varchar(255) NOT NULL,
  `clasificacion` varchar(45) NOT NULL,
  `sinopsis` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `libros`
--

INSERT INTO `libros` (`libro_id`, `titulo`, `autor`, `imagen`, `clasificacion`, `sinopsis`) VALUES
(1, 'Ayer', 'Agota Kristof', 'ayer.jpg', 'ficcion', 'Una inolvidable novela de Agota Kristof; la autora de la trilogia Claus y Lucas. Sandor Lester; exiliado en una fria ciudad europea; lleva una vida solitaria y monotona. Inmerso en una rutina alienante en la fabrica de relojes donde trabaja; pasa sus ratos libres escribiendo; frecuentando a gente en su misma situacion o en compania de Yolande; una mujer a la que no ama. Un dia conoce a Line; una nueva empleada de la fabrica que procede de su mismo pais. Aunque esta casada y tiene una hija de corta edad; Sandor se enamorara de la recien llegada y entre los dos surgira un vinculo tan intimo y esencial como doloroso y destructivo. Al igual que su famosa trilogia Claus y Lucas; esta novela contiene ecos de la propia biografia de Agota Kristof; escritora hungara refugiada en Suiza. En ella utiliza una prosa perfectamente depurada; precisa y despersonalizada con la que crea una penetrante y perturbadora atmosfera para retratar las miserias y crueldades del mundo contemporaneo. Lucida e impactante; Ayer es sin duda una de las mejores obras de la autora.'),
(2, 'Brota', 'Guillermina Lopata', 'brota.jpg', 'autoayuda', 'A veces, el dolor, el hartazgo, el aburrimiento, la tristeza o el enojo abren un ciclo de cambio para que comiences a brotar. Brota es magia poderosa, con rituales para fortalecer tu trabajo interior. Brota es un viaje de valentía hacia tu esencia y tu poder. Brota es una aventura transformadora para crear la vida que deseas. Guillermina Lopata; psicóloga y especialista en saberes integrados (magia, chamanismo, cosmovisiones no tradicionales y espiritualidad); te propone una reconexión profunda con tu niña interior. Así lograrás sanar el pasado y dejar de existir para comenzar a vivir. Encuentra las herramientas para ser tu propia maga y atrévete a brotar. Incluye 39 ejercicios para que lleves tu magia a la acción.'),
(3, 'Caraval', 'Stephanie Garber', 'caraval.jpg', 'ficcion', 'Bienvenidos a Caraval, donde nada es lo que parece... Scarlett no ha salido nunca de la diminuta isla de Trisda, donde sueña con las maravillas de Caraval, una celebración anual de una semana de duración en la que el público puede participar del espectáculo. Caraval es magia. Misterio. Aventura. Y para Scarlett y su querida hermana Tella, representa la libertad y una forma deescapar de su despiadado padre. Cuando las hermanas reciben al fin las ansiadas invitaciones para Caraval, parece que sus sueños se han hecho realidad. Pero Tella desaparece momentos despues de su llegada, secuestrada por el organizador del espectáculo, Legend. Scarlett tiene entendido que todo lo que sucede en Caraval es una compleja ilusión. Sin embargo, pronto se ve sumida en peligroso juego repleto de amor, magia y desconsuelo. Real o no, deberá encontrar a Tella antes de que termine el juego o perdera a su hermana para siempre. \"Recuerda que solo es un juego. Lo que suceda al otro lado de esta puerta podra asustarte o emocionarte, pero no permitas que te engañe\".'),
(4, 'El mentalista', 'Camila Lackberg', 'el-mentalista.jpg', 'ficcion', 'En un parque de atracciones a las afueras de Estocolmo aparece el cuerpo de una joven asesinada de forma macabra: atravesada por múltiples espadas dentro de una caja. La agente de policía Mina Dabiri; reservada y metódica; forma parte del equipo especial de investigación que se hace cargo del caso. Cuando Mina agota todas las posibles pistas; recurre al conocido mentalista Vincent Walder para que los ayude a detectar los indicios que podrían conectar el asesinato con el mundo del ilusionismo. Con la aparición de un nuevo cuerpo; Mina y Vincent entienden que se enfrentan a un despiadado asesino en serie y comienzan una trepidante carrera contrarreloj para descifrar los códigos numéricos y las trampas visuales de una mente brillante y perversa. Un apasionante viaje a la parte más oscura del alma humana que no dejará indiferente a ningún lector. Atrévete a descubrir la verdad.'),
(5, 'El principito', 'A. Saint-Exupéry', 'el-principito.jpg', 'infantil y juvenil', 'Viví así, solo, sin nadie con quien hablar verdaderamente, hasta que tuve una avería en el desierto del Sahara, hace seis años. Algo se había roto en mi motor. Y como no tenía conmigo ni mecánico ni pasajeros, me dispuse a realizar, solo, una reparación difícil. Era, para mí, cuestión de vida o muerte. Tenía agua apenas para ocho días. La primera noche dormí sobre la arena a mil millas de todatierra habitada. Estaba más aislado que un náufrago sobre una balsa en medio del océano. Imaginaos, pues, mi sorpresa cuando, al romper el día, me despertó una extraña vocecita que decía: -Por favor... ¡dibújame un cordero! -¿Eh!? -Dibújame un cordero..'),
(6, 'Encambio', 'Estanislao Bachrach', 'encambio.jpg', 'autoayuda', 'Este año cambio de trabajo, empiezo el gimnasio, bajo esos kilitos de más, aprendo un idioma nuevo... Cambiar. Esa es la cuestión. A veces te da tanto miedo no lograrlo que ni siquiera lo intentás. Vivís en piloto automático, reaccionando a las diversas situaciones del día a día casi sin pensar. Algunos de estos comportamientos te hacen eficiente, pero otros son detractores de eso que querés hoy para vos. EnCambio te va a permitir alumbrar los procesos por los cuales pensás, sentís y te comportás de determinada manera, y así dejar atrás aquellos hábitos y conductas que ya no te sirven. El objetivo es que aprendas el potencial que tiene tu cerebro para cambiar y la capacidad que tenés vos para modificarlo. Con ÁgilMente, Estanislao Bachrach llevó el conocimiento científico del cerebro a la vida cotidiana de miles de lectores. EnCambio lo instala definitivamente como el gran divulgador de la biología de nuestro órgano más complejo y preciado.'),
(7, 'Encanto', 'Disney', 'encanto.jpg', 'infantil', '¡La historia completa de Encanto; acompañada de hermosas ilustraciones!'),
(8, 'Equilibrio', 'Daniel Lopez Rosetti', 'equilibrio.jpg', 'autoayuda', 'Con rigor, erudición, didactismo y amenidad, armado de literaturas, y también de estudios técnicos de última generación; el doctor Daniel López Rosetti nos explica cómo pensamos, cómo sentimos y cómo tomamos decisiones, en un largo y minucioso escaneo de nuestras conductas y nuestros grandes malentendidos. El resultado es un análisis clínico completo de la maquinaria secreta que nos maneja.'),
(9, 'Heartstopper 2', 'Alice Oseman', 'heartstopper.jpg', 'juvenil', 'Segundo tomo del webcómic fenómeno de Tumblr con miles de fans en todo el mundo. Nick y Charlie son mejores amigos. Nick sabe que Charlie es gay; y Charlie está seguro de que Nick no lo es. Pero los caminos del amor pueden ser sorprendentes; y Nick está descubriendo muchas cosas sobre sus amigos; su familia... y sobre sí mismo.'),
(10, 'La larga marcha', 'Stephen King', 'la-larga-marcha.jpg', 'ficcion', '«Todos los juegos son limpios si todo el mundo es engañado a la vez.» El escenario: una sociedad ultraconservadora que ha llevado al paroxismo sus rasgos más perversos; dominada por un estado policial. El acontecimiento: la más extraordinaria competición deportiva; una agotadora marcha a pie; sin ayudas; sin poder disminuir la velocidad; sin meta; donde un solo resbalón puede ser el último. Los competidores: cien adolescentes elegidos por sorteo decididos a pasar sobre los cadáveres de sus compañeros para ganar. El premio: fama y fortuna de por vida para el ganador; el último que quede en pie; el único superviviente. Solo uno triunfará. Los 99 restantes morirán.'),
(11, 'Libera tu magia', 'Elizabeth Gilbert', 'libera-tu-magia.jpg', 'autoayuda', 'Este libro es un relato inspirador; la ruta de acceso a esa vida con la que siempre has soñado. La mayoría de los seres humanos tenemos una faceta creativa que casi nunca conseguimos -o no queremos- desarrollar; por motivos prácticos o personales. Gilbert defiende la necesidad de explorar esa faceta para alcanzar una existencia plena; para lo cual es necesario superar el miedo (a hacer el ridículo; a perder el tiempo; a no ser tomado en serio) y abrazar la parte mística e intangible de la inspiración. La autora explica cómo tener una relación positiva con la propia creatividad; cómo ser disciplinado sin tomárselo demasiado en serio y cómo evitar las grandes expectativas pero; a la vez; no dejarse desanimar. Y asegura que cada pequeño acto cotidiano -hacer un dibujo; decorar la casa o practicar patinaje artístico- alimenta ese costado creativo; que debería formar parte orgánica de nuestras vidas. Al mismo tiempo; desmitifica totalmente la figura del artista atormentado. Defiende en cambio una actitud abierta; receptiva y posit iva en busca de la inspiración como resultado de la curiosidad sana; la disciplina y la determinación; que permiten poner límites al ego para poder sobrellevar decepciones y fracasos. «La creatividad es sagrada y al mismo tiempo no lo es. Lo que hacemos importa muchísimo y al mismo tiempo no importa nada. Trabajamos en soledad; y nos acompañan espíritus. Estamos aterrorizados y somos valientes. El arte es una tarea abrumadora y un privilegio maravilloso. El trabajo quiere ser hecho; y quiere ser hecho por ti.»'),
(12, 'Rayuela', 'Julio Cortázar', 'rayuela.jpg', 'ficcion', '«En pleno contento precario; en plena falsa tregua; tendí la mano y toqué el ovillo París; su materia infinita arrollándose a sí misma; entonces no había desorden; entonces el mundo seguía siendo algo petrificado y establecido; un juego de elementos girando en sus goznes; una madeja de calles y árboles y nombres y meses.» En Rayuela (1963); Julio Cortázar supo condensar sus obsesiones estéticas; literarias y vitales a partir de un mosaico diverso; prof undo; inagotable que; a su vez; refleja de forma maravillosa lo más esencial de su época. El amor turbulento de Oliveira y La Maga; los amigos del Club de la Serpiente; las impredecibles caminatas por París -la ciudad que promete el cielo pero puede conducir al infierno-; encuentran su contracara en la aventura protagonizada por Oliveira; Talita y Traveler en Buenos Aires. Rayuela es un libro único; abierto a múltiples lecturas; lúdico; complejo; lleno de riesgo y humor; de una originalidad sin precedentes y un talento innato para influir en las futuras generaciones.'),
(13, 'Red la novela', 'Disney', 'red-lanovela.jpg', 'infantil', 'Red trata sobre Mei, una chica de trece años un poco torpe pero segura de sí misma, que tiene que escoger entre vivir el caos de la adolescencia o ser una hija obediente. Además de los cambios propios de su edad (de sus intereses; relaciones y su cuerpo mismo); Mei comienza a transformarse en un panda rojo gigante cuando se desbordan sus emociones; ¡que es casi todo el tiempo!'),
(14, 'Reino de papel', 'Victoria Resco', 'reino-de-papel.jpg', 'juvenil', 'Para quien la mire no es otra cosa que perfecta e inquebrantable. Popular. Bonita. Inalcanzable. Toda una profesional de la mentira. Pero cuando todo a su alrededor se vuelve un caos y los muros que tan perfectamente ha construido en su interior comienzan a resquebrajarse; un chico y su gato malhumorado entran como un rayo de sol a su cielo nublado y ponen su vida de cabeza. Aaron llena sus días de color y ruiseñores. Le muestra caras de sí misma que no sabía que tenía. Que la aterran. Que la increpan. Que la hacen desear ser esa chica que nunca creyó poder ser. ¿Podrá una nueva Aspen surgir de entre tanta oscuridad y tantas mentiras?'),
(15, 'Volver a mí', 'Laura G. Miranda', 'volver-a-mi.jpg', 'ficcion', '¿Dónde queda la PASIÓN cuando todo en la vida es rutina y deber? ¿Es posible VOLVER a empezar? ¿Se puede volver a VIBRAR POR AMOR? Volver a mí retrata la vida de una mujer que cumplió todos los mandatos sociales: ser profesional; esposa y madre; pero que a fuerza de lograr los sueños ajenos olvidó los propios. A veces; perderse es la única forma de encontrarse.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resenias`
--

CREATE TABLE `resenias` (
  `resenia_id` varchar(255) NOT NULL,
  `usuario_id` int(10) UNSIGNED NOT NULL,
  `libro_id` int(10) UNSIGNED NOT NULL,
  `recomiendo` varchar(3) NOT NULL,
  `comentario` varchar(255) NOT NULL,
  `fecha_publicacion` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `resenias`
--

INSERT INTO `resenias` (`resenia_id`, `usuario_id`, `libro_id`, `recomiendo`, `comentario`, `fecha_publicacion`) VALUES
('4c320a43-be83-4d0c-b44a-2f60c71931df', 8, 3, 'si', 'Un libro que no podes dejar de leer desde que lo empezás. Recomendadísimo!!', '2023-12-13 00:38:32'),
('745b59aa-7a56-4a59-8f11-42c3ed9ac30b', 11, 3, 'no', 'Me pareció bastante aburrido y predecible.', '2023-12-13 00:40:45'),
('991c3c39-3f33-4643-9c26-f3f003da5af1', 12, 2, 'no', 'No me gustó.', '2023-12-16 22:14:22');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `usuario_id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`usuario_id`, `nombre`, `email`, `password`) VALUES
(8, 'Juli', 'julieta@mail.com', '$2y$10$pYIB.G2mTB3VJNynvW3aEuqnsFY3VPmrias97wpjRE74nOuhB5hFC'),
(11, 'Dárgelos', 'dargelos@mail.com', '$2y$10$BkJSjcXaBAeC04c8pMiRouXO7pl/h6Qj683YbIBI.PjeROCzNNZBC'),
(12, 'Emma', 'emma@mail.com', '$2y$10$8AzwIwkn6Unz5xFZf3Ej3Ot9CA3GZOV65D6eAbF6dNYZBjm5wtLyy');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `favoritos`
--
ALTER TABLE `favoritos`
  ADD PRIMARY KEY (`libro_id`,`usuario_id`),
  ADD KEY `usuarios_favoritos_libros_idx` (`usuario_id`);

--
-- Indices de la tabla `libros`
--
ALTER TABLE `libros`
  ADD PRIMARY KEY (`libro_id`);

--
-- Indices de la tabla `resenias`
--
ALTER TABLE `resenias`
  ADD PRIMARY KEY (`resenia_id`),
  ADD KEY `resenias_usuarios_fk_idx` (`usuario_id`),
  ADD KEY `fk_resenias_libros1_idx` (`libro_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`usuario_id`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `libros`
--
ALTER TABLE `libros`
  MODIFY `libro_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `usuario_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `favoritos`
--
ALTER TABLE `favoritos`
  ADD CONSTRAINT `libros_favoritos_usuarios` FOREIGN KEY (`libro_id`) REFERENCES `libros` (`libro_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `usuarios_favoritos_libros` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`usuario_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `resenias`
--
ALTER TABLE `resenias`
  ADD CONSTRAINT `resenias_libros_fk` FOREIGN KEY (`libro_id`) REFERENCES `libros` (`libro_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `resenias_usuarios_fk` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`usuario_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
