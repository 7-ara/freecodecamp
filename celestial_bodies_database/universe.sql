--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(30) NOT NULL,
    messier_number integer,
    galaxy_type_id integer NOT NULL,
    isophotal_diameter_in_kpc numeric(4,2),
    distance_from_milky_way_in_mpc numeric(4,2)
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: galaxy_type; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy_type (
    galaxy_type_id integer NOT NULL,
    name character varying(20) NOT NULL,
    description text
);


ALTER TABLE public.galaxy_type OWNER TO freecodecamp;

--
-- Name: galaxy_type_galaxy_type_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_type_galaxy_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_type_galaxy_type_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_type_galaxy_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_type_galaxy_type_id_seq OWNED BY public.galaxy_type.galaxy_type_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(30) NOT NULL,
    planet_id integer NOT NULL,
    radius_in_earth_radii numeric(8,4),
    mass_in_earth_masses numeric(8,6)
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(30) NOT NULL,
    star_id integer NOT NULL,
    radius_in_earth_radii numeric(6,2),
    mass_in_earth_masses numeric(6,2),
    has_life boolean,
    number_of_moons integer,
    orbit_is_retrograde boolean
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: spectral_class; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.spectral_class (
    spectral_class_id integer NOT NULL,
    name character varying(1) NOT NULL,
    min_temp_in_kk numeric(3,1)
);


ALTER TABLE public.spectral_class OWNER TO freecodecamp;

--
-- Name: spectral_class_spectral_class_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.spectral_class_spectral_class_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.spectral_class_spectral_class_id_seq OWNER TO freecodecamp;

--
-- Name: spectral_class_spectral_class_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.spectral_class_spectral_class_id_seq OWNED BY public.spectral_class.spectral_class_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(30) NOT NULL,
    galaxy_id integer NOT NULL,
    spectral_class_id integer,
    radius_in_solar_radii numeric(6,2),
    mass_in_solar_masses numeric(6,2)
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: galaxy_type galaxy_type_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy_type ALTER COLUMN galaxy_type_id SET DEFAULT nextval('public.galaxy_type_galaxy_type_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: spectral_class spectral_class_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.spectral_class ALTER COLUMN spectral_class_id SET DEFAULT nextval('public.spectral_class_spectral_class_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', NULL, 1, 26.80, 0.00);
INSERT INTO public.galaxy VALUES (2, 'Andromeda Galaxy', 31, 1, 46.56, 0.77);
INSERT INTO public.galaxy VALUES (3, 'Messier 87', 87, 2, 40.55, 16.40);
INSERT INTO public.galaxy VALUES (4, 'Large Magellanic Cloud', NULL, 3, 9.96, 0.16);
INSERT INTO public.galaxy VALUES (5, 'Small Magellanic Cloud', NULL, 3, 5.78, 0.21);
INSERT INTO public.galaxy VALUES (6, 'Triangulum Galaxy', 33, 1, 18.74, 0.97);


--
-- Data for Name: galaxy_type; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy_type VALUES (1, 'spiral', 'Spiral morphology');
INSERT INTO public.galaxy_type VALUES (2, 'elliptical', 'Elliptical morphology');
INSERT INTO public.galaxy_type VALUES (3, 'irregular', 'Irregular morphology');


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Moon', 1, 0.2727, 0.012300);
INSERT INTO public.moon VALUES (2, 'Ganymede', 5, 0.4130, 0.024800);
INSERT INTO public.moon VALUES (3, 'Titan', 6, 0.4037, 0.022500);
INSERT INTO public.moon VALUES (4, 'Callisto', 5, 0.3783, 0.018000);
INSERT INTO public.moon VALUES (5, 'Io', 5, 0.2859, 0.015000);
INSERT INTO public.moon VALUES (6, 'Europa', 5, 0.2450, 0.008035);
INSERT INTO public.moon VALUES (7, 'Triton', 8, 0.2124, 0.003599);
INSERT INTO public.moon VALUES (8, 'Titania', 7, 0.1237, 0.000590);
INSERT INTO public.moon VALUES (9, 'Rhea', 6, 0.1199, 0.000390);
INSERT INTO public.moon VALUES (10, 'Oberon', 7, 0.1195, 0.000500);
INSERT INTO public.moon VALUES (11, 'Iapetus', 6, 0.1153, 0.000330);
INSERT INTO public.moon VALUES (12, 'Umbriel', 7, 0.0918, 0.000200);
INSERT INTO public.moon VALUES (13, 'Ariel', 7, 0.0909, 0.000226);
INSERT INTO public.moon VALUES (14, 'Dione', 6, 0.0881, 0.000183);
INSERT INTO public.moon VALUES (15, 'Tethys', 6, 0.0834, 0.000103);
INSERT INTO public.moon VALUES (16, 'Proteus', 8, 0.0328, 0.000004);
INSERT INTO public.moon VALUES (17, 'Enceladus', 6, 0.0395, 0.000018);
INSERT INTO public.moon VALUES (18, 'Miranda', 7, 0.0370, 0.000011);
INSERT INTO public.moon VALUES (19, 'Nereid', 8, 0.0280, 0.000006);
INSERT INTO public.moon VALUES (20, 'Mimas', 6, 0.0311, 0.000006);
INSERT INTO public.moon VALUES (21, 'Hyperion', 6, 0.0212, 0.000001);
INSERT INTO public.moon VALUES (22, 'Phoebe', 6, 0.0167, 0.000001);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Earth', 1, 1.00, 1.00, true, 1, false);
INSERT INTO public.planet VALUES (2, 'Mercury', 1, 0.38, 0.06, false, 0, false);
INSERT INTO public.planet VALUES (3, 'Venus', 1, 0.95, 0.82, false, 0, true);
INSERT INTO public.planet VALUES (4, 'Mars', 1, 0.53, 0.11, false, 2, false);
INSERT INTO public.planet VALUES (5, 'Jupiter', 1, 11.20, 317.80, false, 95, false);
INSERT INTO public.planet VALUES (6, 'Saturn', 1, 9.14, 95.16, false, 146, false);
INSERT INTO public.planet VALUES (7, 'Uranus', 1, 4.01, 14.54, false, 28, true);
INSERT INTO public.planet VALUES (8, 'Neptune', 1, 3.88, 17.15, false, 16, false);
INSERT INTO public.planet VALUES (9, 'WASP-17b', 7, 22.29, 162.71, NULL, NULL, false);
INSERT INTO public.planet VALUES (10, 'Stockhausen', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.planet VALUES (11, 'Proxima Centauri b', 8, 1.04, 1.07, NULL, NULL, NULL);
INSERT INTO public.planet VALUES (12, 'Proxima Centauri d', 8, 0.81, 0.26, NULL, NULL, NULL);


--
-- Data for Name: spectral_class; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.spectral_class VALUES (1, 'O', 33.0);
INSERT INTO public.spectral_class VALUES (2, 'B', 10.0);
INSERT INTO public.spectral_class VALUES (3, 'A', 7.3);
INSERT INTO public.spectral_class VALUES (4, 'F', 6.0);
INSERT INTO public.spectral_class VALUES (5, 'G', 5.3);
INSERT INTO public.spectral_class VALUES (6, 'K', 3.9);
INSERT INTO public.spectral_class VALUES (7, 'M', 2.3);
INSERT INTO public.spectral_class VALUES (8, 'D', NULL);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Sun', 1, 5, 1.00, 1.00);
INSERT INTO public.star VALUES (2, 'Sirius A', 1, 3, 1.71, 2.10);
INSERT INTO public.star VALUES (3, 'Sirius B', 1, 8, 0.01, 1.20);
INSERT INTO public.star VALUES (4, 'Antares A', 1, 7, 680.00, 13.50);
INSERT INTO public.star VALUES (5, 'Antares B', 1, 2, 5.20, 7.20);
INSERT INTO public.star VALUES (6, 'WOH G64', 4, 7, 1540.00, 25.00);
INSERT INTO public.star VALUES (7, 'WASP-17', 1, 4, 1.38, 1.20);
INSERT INTO public.star VALUES (8, 'Proxima Centauri', 1, 7, 0.15, 0.12);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: galaxy_type_galaxy_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_type_galaxy_type_id_seq', 3, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 22, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 12, true);


--
-- Name: spectral_class_spectral_class_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.spectral_class_spectral_class_id_seq', 8, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 8, true);


--
-- Name: galaxy galaxy_messier_number_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_messier_number_key UNIQUE (messier_number);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: galaxy_type galaxy_type_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy_type
    ADD CONSTRAINT galaxy_type_name_key UNIQUE (name);


--
-- Name: galaxy_type galaxy_type_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy_type
    ADD CONSTRAINT galaxy_type_pkey PRIMARY KEY (galaxy_type_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: spectral_class spectral_class_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.spectral_class
    ADD CONSTRAINT spectral_class_name_key UNIQUE (name);


--
-- Name: spectral_class spectral_class_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.spectral_class
    ADD CONSTRAINT spectral_class_pkey PRIMARY KEY (spectral_class_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: galaxy galaxy_galaxy_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_galaxy_type_id_fkey FOREIGN KEY (galaxy_type_id) REFERENCES public.galaxy_type(galaxy_type_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- Name: star star_spectral_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_spectral_class_id_fkey FOREIGN KEY (spectral_class_id) REFERENCES public.spectral_class(spectral_class_id);


--
-- PostgreSQL database dump complete
--

