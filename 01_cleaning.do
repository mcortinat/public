*----------------------------------------------------*
* 	Women to Women: TA as Role Models in Economics   *
* 	Magdalena Cortina								 *
* 	Dofile 1: Cleaning 								 *
*----------------------------------------------------*

set more off
clear all
version 16.1

* This do-file is for cleaning and exploring data

* Magdalena

global path 	"/Users/mcortinat/Library/Mobile Documents/com~apple~CloudDocs/Desktop/research/public/women_in_econ/"
global pathD	"${path}02_data/"
global pathR	"${path}03_results/"

use "${pathD}base_uai.dta"

****************+**** INFROMACION SOBRE PROGRAMAS ****************************

* estas son todos los programas de la universidad. Los elimino todos para quedarme solo con comercial
drop if programa==	"DERECHO" 
drop if programa==	"BACHILLERATO DE INGENIERÍA CIVIL"
drop if programa==	"DISEÑO"
drop if programa==	"HISTORIA"
drop if programa==	"INGENIERÍA CIVIL"
drop if programa==	"INGENIERÍA CIVIL - PLAN COMÚN"
drop if programa==	"INGENIERÍA CIVIL EN BIOINGENIERÍA"
drop if programa==	"INGENIERÍA CIVIL EN ENERGÍA Y MEDIOAMBIENTE"
drop if programa==	"INGENIERÍA CIVIL EN INFORMÁTICA Y TELECOMUNICACIONES"
drop if programa==	"INGENIERÍA CIVIL EN MINERÍA"
drop if programa==	"INGENIERÍA CIVIL EN OBRAS CIVILES"
drop if programa==	"INGENIERÍA CIVIL INDUSTRIAL"
drop if programa==	"INGENIERÍA CIVIL INFORMÁTICA"
drop if programa==	"INGENIERÍA CIVIL MECÁNICA"
drop if programa==	"INGENIERÍA COMERCIAL"
drop if programa==	"INGENIERÍA EN DISEÑO"
drop if programa==	"LICENCIATURA EN ARTES LIBERALES"
drop if programa==	"PERIODISMO MENCIÓN ECONOMÍA Y NEGOCIOS"
drop if programa==	"PERIODISMO MENCIÓN HISTORIA Y POLÍTICA"
drop if programa==	"PERIODISMO MENCIÓN LITERATURA Y ARTE"
drop if programa==	"PSICOLOGÍA"
drop if programa==	"LICENCIATURA EN CIENCIAS SOCIALES PLAN COMÚN"
drop if programa==	"BACHILLERATO DE INGENIERÍA COMERCIAL"
drop if programa==	"PERIODISMO"

/* Genero una nueva variable para juntar a todos los alumnos de comercial en el mismo programa
por algluna razon hay distintos nombres de programas
Estoy dejando fuera a bachillerato de ingeniería comercial*/ 

generate 	carrera=.
replace 	carrera=1 if programa=="INGENIERÍA COMERCIAL - PLAN COMÚN"
replace 	carrera=1 if programa=="INGENIERÍA COMERCIAL LC"
replace 	carrera=1 if programa=="INGENIERÍA COMERCIAL LCS"
replace 	carrera=1 if programa=="INGENIERÍA COMERCIAL - LICENCIATURA EN ECONOMÍA"
drop 		programa
rename 		carrera programa
label 		define carrera 1 "ING COMERCIAL"
label 		values programa carrera /* ahora  la variable se llama programa */
drop if 	programa==.

* Informacion de SEDE de la universidad
gen 		codigo_sede=.
replace 	codigo_sede=1 if sede=="STGO"
replace 	codigo_sede=2 if sede=="VIÑA"
label 		define sed 1 "STGO" 2 "VIÑA"
label 		values codigo_sede sed
drop 		sede 

************************ INFORMACION SOBRE CURSOS *******************************

/* me quedo con las asignaturas que necesito
son todas las de la malla hasta antes de economia matematica */

keep if sigla=="LING102" | sigla=="MGT101" | sigla=="ECO121" | sigla=="MAT108" | sigla=="MAT112"  | sigla=="LTR101" | sigla=="MGT130" | sigla=="ACCT111"| sigla=="MAT118" | sigla=="ECO221" | sigla=="GOB101" | sigla=="ING101" | sigla=="ACCT221" | sigla=="MAT128" | sigla=="ECO201" | sigla=="MGT212" | sigla=="LID101" | sigla=="PHI121" | sigla=="ING103" | sigla=="ECO211" | sigla=="MAT129" | sigla=="EST103" | sigla=="MGT238" | sigla=="LING111" | sigla=="ECO301" | sigla=="MKT301"

gen asignatura=.
replace asignatura=1 	if sigla=="ECO121"
replace asignatura=2 	if sigla=="MAT108" 
replace asignatura=3 	if sigla=="MAT112"
replace asignatura=4 	if sigla=="MAT118"
replace asignatura=5 	if sigla=="ECO221"
replace asignatura=6 	if sigla=="MAT128"
replace asignatura=7 	if sigla=="ECO201"
replace asignatura=8 	if sigla=="ECO211"
replace asignatura=9 	if sigla=="MAT129"
replace asignatura=10 	if sigla=="EST103"
replace asignatura=11 	if sigla=="ECO301"
replace asignatura=12 	if sigla=="LING102"
replace asignatura=13 	if sigla=="MGT101"
replace asignatura=14 	if sigla=="LTR101"
replace asignatura=15 	if sigla=="MGT130"
replace asignatura=16 	if sigla=="ACCT111"
replace asignatura=17 	if sigla=="GOB101"
replace asignatura=18 	if sigla=="ING101"
replace asignatura=19 	if sigla=="ACCT221"
replace asignatura=20 	if sigla=="MGT212"
replace asignatura=21 	if sigla=="LID101"
replace asignatura=22 	if sigla=="PHI121"
replace asignatura=23 	if sigla=="ING103"
replace asignatura=24 	if sigla=="MGT238"
replace asignatura=25 	if sigla=="LING111"
replace asignatura=26 	if sigla=="MKT301"

** defino nombres de asignaturas en orden cronologico **
label define asig 	1 "Intro a la Economia" 		///
					2 "Calculo I" 					///
					3 "Algebra I" 					///
					4 "Calculo II" 					///
					5 "Macro I" 					///	
					6 "Calculo III" 				///
					7 "Micro I" 					///
					8 "Micro II" 					///
					9 "Algebra II" 					///
					10 "Estadistica I" 				///
					11 "Economia Matematica" 		///
					12 "Expresión Escrita" 			///
					13 "TIN" 						///
					14 "Lectura Crítica" 			///
					15 "TEM" 						///
					16 "Contabilidad I" 			///
					17 "Política" 					///
					18 "Ciencias 1" 				///
					19 "Contabilidad II" 			///
					20 "Personas" 					///
					21 "Liderazgo I" 				///	
					22 "Argumentación" 				///	
					23 "Ciencias 2" 				///
					24 "Entorno" 					///
					25  "LING111" 					///	
					26 "Marketing I"				///

label 	value asignatura asig 
label 	variable asignatura "nombre asignatura"

** genero variable de area de cada asignatura **
gen area=.
replace area=1 if sigla=="ECO121" | sigla=="ECO201" | sigla=="ECO221" | sigla=="ECO211"
replace area=2 if sigla=="MAT108" | sigla=="MAT112" | sigla=="MAT118" 
replace area=3 if sigla=="LING102"| sigla=="MGT101" | sigla=="LTR101" | sigla=="MGT130" | sigla=="ACCT221" | sigla=="GOB101" | sigla=="ING101" | sigla=="ACCT221" | sigla=="MGT212"| sigla=="LID101" | sigla=="PHI121" | sigla=="ING103" | sigla=="MGT238" | sigla=="LING111" | sigla=="EST103"

label 	define area1 1 "Área Economica" 2 "Área matemática" 3 "Otra"
label 	values area area1


/* Variable de reprobaciones:                               */

gen reprob=0
replace reprob=1 if nota<4.0 & nota!=.
label define rep 1 "reprobado" 0 "aprobado"
label value reprob rep
label variable reprob "reprobación"

/* id_obs=1 deja una sola observacion por alumno. hay mas de una porque hay mas de un ayudante por seccion. cuando hay un ayudante por seccion deberia ser 1 */
duplicates drop
bys id_alumno asignatura id_sec: gen id_obs=_n
gen reprobaciones=.
replace reprobaciones=1 if reprob==1 & id_obs==1 /* aquí la variable relevante es reprobaciones */ 

/* reprobaciones por area
luego estas variables van con sum en el collapse, entonces indicarán el
número de reprobaciones por area */
gen rep_eco=0
replace rep_eco=1 if reprobaciones==1 & area==1

gen rep_mat=0
replace rep_mat=1 if reprobaciones==1 & area==2

gen rep_otra=0
replace rep_otra=1 if reprobaciones==1 & area==3

/* voy a generar dummies de cada ramo. Asi despues puedo botar las observaciones que no tienen todos los ramos
y ademas le agrego que este aprobado, ya que así se que tiene el requisito. */

gen 	eco121=0
replace eco121=1 if sigla=="ECO121" & reprob==0
gen 	eco201=0
replace eco201=1 if sigla=="ECO201" & reprob==0
gen 	eco211=0
replace eco211=1 if sigla=="ECO211" 
gen 	eco221=0
replace eco221=1 if sigla=="ECO221" 
gen 	mat108=0
replace mat108=1 if sigla=="MAT108" & reprob==0 
gen 	mat118=0
replace mat118=1 if sigla=="MAT118" & reprob==0
gen 	mat128=0
replace mat128=1 if sigla=="MAT128" & reprob==0
gen 	mat112=0
replace mat112=1 if sigla=="MAT112" & reprob==0
gen 	mat129=0
replace mat129=1 if sigla=="MAT129" & reprob==0

gen 	mgt101=.
replace mgt101=1 if sigla=="MGT101" 
gen 	mgt130=.
replace mgt130=1 if sigla=="MGT130" 
gen 	acct111=.
replace acct111=1 if sigla=="ACCT111" 

gen 	eco301=.
replace eco301=1 if sigla=="ECO301" &  reprob==0
gen 	eco225=.
replace eco225=1 if sigla=="ECO225" & reprob==0

** enumero los semestres
gen semest=.
replace semest=1 	if semestre=="2012/1"
replace semest=2 	if semestre=="2012/2"
replace semest=3	if semestre=="2013/1"
replace semest=4 	if semestre=="2013/2"
replace semest=5 	if semestre=="2014/1"
replace semest=6 	if semestre=="2014/2"
replace semest=7 	if semestre=="2015/1"
replace semest=8 	if semestre=="2015/2"
replace semest=9 	if semestre=="2016/1"
replace semest=10 	if semestre=="2016/2"
replace semest=11 	if semestre=="2017/1"
replace semest=12 	if semestre=="2017/2"
replace semest=13 	if semestre=="2018/1"
replace semest=14 	if semestre=="2018/2"
replace semest=15 	if semestre=="2019/1"
replace semest=16 	if semestre=="2019/2"

** semestre en q tomo ecomate, macro 1 y micro 2. luego del collapse veo cual fue antes
* este es collapse(min) ya que quiero quedarme con la primera vez que tomo el ramo
gen 	sem_eco301=.
replace sem_eco301=semest if sigla=="ECO301"
gen 	sem_eco221=.
replace sem_eco221=semest if sigla=="ECO221"
gen 	sem_eco211=.
replace sem_eco211=semest if sigla=="ECO211"
gen 	sem_mkt301=.
replace sem_mkt301=semest if sigla=="MKT301"
gen 	sem_mgt101=.
replace sem_mgt101=semest if sigla=="MGT101"
gen 	sem_mgt130=.
replace sem_mgt130=semest if sigla=="MGT130"
gen 	sem_acct=.
replace sem_acct=semest   if sigla=="ACCT111"


*********************** INFORMACION SOBRE ALUMNOS ******************************

// transformar algunas variables a numericas para sacar promedios etc y nombrar valores
global PSU = "psu_ciencias psu_hist psu_lenguaje psu_mat nem puntaje_ponderado promedio_psu puntaje_ranking"
****** FALTA PUNTAJE RANKING!!!!!!

foreach i of global PSU {
	replace `i'="." if `i'=="NA"
	replace `i'="." if `i'=="SIN INFO"
	destring `i', replace
}

** descripcion variables
label variable psu_ciencias 		"ptje PSU ciencias"
label variable psu_mat				"ptje PSU matematica"
label variable psu_leng 			"ptje psu lenguaje" 
label variable nem 					"puntaje NEM"
label variable psu_hist 			"ptje PSU historia"
label variable puntaje_ranking 		"ptje NEM ranking"
label variable puntaje_ponderado 	"ptje ponderado comercial UAI"
label variable promedio_psu 		"promedio simple ptjes psu"
label variable num_sec 				"numero de la seccion"

** tipo colegio
replace tipo_colegio="." if tipo_colegio=="No disponible"
encode tipo_colegio, gen(tipocolegio)

gen 	particular=0
replace particular=1 	if tipocolegio==3
replace particular=. 	if tipocolegio==.
gen 	subvencionado=0
replace subvencionado=1 if tipocolegio==4
replace subvencionado=. if tipocolegio==.
gen 	municipal=0
replace municipal=1 	if tipocolegio==2
replace municipal=. 	if tipocolegio==.

drop tipocolegio tipo_colegio

* genero variable numerica del programa de quinto año *
encode programa_quinto, generate(quinto)
drop programa_quinto

* genero dummy de admision especial *
gen adm_especial=.
replace adm_especial=1 if tipo_postulacion=="ESPECIAL"
replace adm_especial=0 if tipo_postulacion=="REGULAR"
drop tipo_postulacion
label define post 1 "ESPECIAL" 0 "REGULAR"
label values adm_especial post
label variable adm_especial "Tipo de postulacion"

*dummy de alumna mujer *
gen mujer=0
replace mujer=1 if genero=="F"

/* Dummy de alumno de economía: inscribir el ramo economía matemática  */
gen ecomate=0
replace ecomate=1 if sigla=="ECO301"

/* Dummy de alumno de administracion: inscribir el ramo marketing I  */
gen marketing=0
replace marketing=1 if sigla=="MKT301"

* variable de pormedio general acomulado incluyendo reprobaciones  (prerequisitos)*
bys id_alumno: egen prom_prer=mean(nota) if id_obs==1 & area==1 | area==2
label variable prom_prer "promedio prerequisitos, incluyento reprobaciones"

* variable de promedio general acomulado incluyendo solo ramos aprobados* 
replace nota=. if sigla=="ECO301" // para que no se incluya ecomate en el promedio
bys id_alumno: egen prom_acum_a=mean(nota) if id_obs==1 & reprob==0
label variable prom_acum_a "promedio acomulado, ramos aprobados"

/* variables de promedio de notas por area: se colapsan con max
area matematica, area economica y el resto. Considerar todos los ramos */
bys id_alumno: egen prom_eco=mean(nota) if id_obs==1 & area==1 
bys id_alumno: egen prom_mat=mean(nota) if id_obs==1 & area==2 
bys id_alumno: egen prom_otra=mean(nota) if id_obs==1 & area==3 

bys id_alumno: egen nota_e121=mean(nota) if id_obs==1 & sigla=="ECO121"
bys id_alumno: egen nota_e201=mean(nota) if id_obs==1 & sigla=="ECO201"
bys id_alumno: egen nota_e221=mean(nota) if id_obs==1 & sigla=="ECO221"
bys id_alumno: egen nota_e211=mean(nota) if id_obs==1 & sigla=="ECO211"
bys id_alumno: egen nota_m108=mean(nota) if id_obs==1 & sigla=="MAT108"
bys id_alumno: egen nota_m118=mean(nota) if id_obs==1 & sigla=="MAT118"
bys id_alumno: egen nota_m112=mean(nota) if id_obs==1 & sigla=="MAT112"
bys id_alumno: egen nota_m101=mean(nota) if id_obs==1 & sigla=="MGT101"
bys id_alumno: egen nota_m130=mean(nota) if id_obs==1 & sigla=="MGT130"
bys id_alumno: egen nota_a111=mean(nota) if id_obs==1 & sigla=="ACCT111"

* Elimino cohortes que vienen antes del 2011, ya que no elegian entre eco o adm.
* Elimino cohorte 2020. Aun no terminan el cuarto semestre.

drop if cohorte==2004
drop if cohorte==2005
drop if cohorte==2006
drop if cohorte==2007
drop if cohorte==2008
drop if cohorte==2009
drop if cohorte==2010
drop if cohorte==2011
drop if cohorte==2012
drop if cohorte==2020
drop if cohorte==2021


**
bys 	id_alumno sigla id_sec: gen id_ay=_n
sort 	id_sec id_ayudante  id_alumno 
order 	id_sec id_ayudante id_alumno 

/* este va a ser el numero de lista de cada alumno, por ayuante. 
Tomo solo 1 obs de la lista para tomar informacion comun acerca de la seccion
Con esto me aseguro de tomar  solo 1 observacion por ayudante, por seccion */
bys id_sec id_ayudante: gen lista=_n
bys id_sec id_prof: gen listap=_n
bys id_prof: gen listap2=_n
* rendimiento promedio de la seccion
bys id_sec id_ayudante: egen rend=mean(nota) 
bys id_sec: gen nsec=_n
**

global R = "eco121 eco201 eco221 eco211 mat108 mat118 mat112 eco mat"
foreach r of global R{
	gen rend_`r'=.
}

replace rend_eco121=rend if sigla=="ECO121"
replace rend_eco201=rend if sigla=="ECO201"
replace rend_eco221=rend if sigla=="ECO221"
replace rend_eco211=rend if sigla=="ECO211"
replace rend_mat108=rend if sigla=="MAT108"
replace rend_mat118=rend if sigla=="MAT118"
replace rend_mat112=rend if sigla=="MAT112"

* collapse mean
replace rend_eco=rend if sigla=="ECO221"
replace rend_eco=rend if sigla=="ECO211"
replace rend_mat=rend if sigla=="MAT108"
replace rend_mat=rend if sigla=="MAT118"
replace rend_mat=rend if sigla=="MAT112"

/* Dummies de genero de ayudante de cursos relevantes pre economía matematicaa
(si  al menos tuvo un ayudante mujer) 

para las siguientes dummies "ay" significa ayudante mujer. 
"ayh" significa ayudante hombre 
Q indica que sera la varible de cantidad de ayudantes 
Lic indica ayudante de la licenciatura en economia */

encode gen_ayud, gen(gen_ayudante)
replace gen_ayudante=. if gen_ayudante==3

global Y = "eco121 mat108 mat112 mat118 eco221 eco201 eco211 mgt101 mgt130 acct111"
foreach i of global Y{
		gen ay_`i'=0
		gen ayh_`i'=0
		gen Qay_`i'=0
		gen Qayh_`i'=0
}

replace ay_eco121=1 if gen_ayudante==1 & sigla=="ECO121" 
replace ay_mat108=1 if gen_ayudante==1 & sigla=="MAT108" 
replace ay_mat112=1 if gen_ayudante==1 & sigla=="MAT112" 
replace ay_mat118=1 if gen_ayudante==1 & sigla=="MAT118" 
replace ay_eco221=1 if gen_ayudante==1 & sigla=="ECO221" 
replace ay_eco201=1 if gen_ayudante==1 & sigla=="ECO201"
replace ay_eco211=1 if gen_ayudante==1 & sigla=="ECO211" 

** asignaturas administracion
replace ay_mgt101=1 if gen_ayudante==1 & sigla=="MGT101"
replace ay_mgt130=1 if gen_ayudante==1 & sigla=="MGT130"
replace ay_acct111=1 if gen_ayudante==1 & sigla=="ACCT111"

** dummies de ayudante hombre **
replace ayh_eco121=1 if gen_ayudante==2 & sigla=="ECO121" 
replace ayh_mat108=1 if gen_ayudante==2 & sigla=="MAT108" 
replace ayh_mat112=1 if gen_ayudante==2 & sigla=="MAT112" 
replace ayh_mat118=1 if gen_ayudante==2 & sigla=="MAT118" 
replace ayh_eco221=1 if gen_ayudante==2 & sigla=="ECO221" 
replace ayh_eco201=1 if gen_ayudante==2 & sigla=="ECO201"
replace ayh_eco211=1 if gen_ayudante==2 & sigla=="ECO211" 

/** ahora vuelvo a generar las mismas dummies pero para hacer collapse(sum)
y saber la  cantidad de ayudantes mujeres hombres q tuvo el alumnos x curso */

replace Qay_eco121=1 if gen_ayudante==1 & sigla=="ECO121" 
replace Qay_mat108=1 if gen_ayudante==1 & sigla=="MAT108" 
replace Qay_mat112=1 if gen_ayudante==1 & sigla=="MAT112" 
replace Qay_mat118=1 if gen_ayudante==1 & sigla=="MAT118" 
replace Qay_eco221=1 if gen_ayudante==1 & sigla=="ECO221" 
replace Qay_eco201=1 if gen_ayudante==1 & sigla=="ECO201"
replace Qay_eco211=1 if gen_ayudante==1 & sigla=="ECO211" 

gen 	Qayud_eco=0
replace Qayud_eco=1 if gen_ayudante==1 & area==1

gen 	Qayud_mat=0
replace Qayud_mat=1 if gen_ayudante==1 & area==2

** genero dummies de cantidad de ayudantes hombre **
replace Qayh_eco121=1 if gen_ayudante==2 & sigla=="ECO121" 
replace Qayh_mat108=1 if gen_ayudante==2 & sigla=="MAT108" 
replace Qayh_mat112=1 if gen_ayudante==2 & sigla=="MAT112" 
replace Qayh_mat118=1 if gen_ayudante==2 & sigla=="MAT118" 
replace Qayh_eco221=1 if gen_ayudante==2 & sigla=="ECO221" 
replace Qayh_eco201=1 if gen_ayudante==2 & sigla=="ECO201"
replace Qayh_eco211=1 if gen_ayudante==2 & sigla=="ECO211" 

gen 	Qayudh_eco=0
replace Qayudh_eco=1 if gen_ayudante==2 & area==1

gen 	Qayudh_mat=0
replace Qayudh_mat=1 if gen_ayudante==2 & area==2

/* genero variable ayudante_economia 
me dira si el ayudante pertenece a la lic de economia o no */

rename 	licenciatura_en_economia ayud_econommia
gen 	ayud_economia=.
replace ayud_economia=1 if ayud_econommia=="SI"
replace ayud_economia=0 if ayud_econommia=="NO"
label 	define AYUDEC 1 "SI" 0 "NO"
label 	values ayud_economia AYUDEC
drop 	ayud_econommia
** genero dummy de ayudante MUJER de la licenciatura por ramo **
global L = "e121 e201 m108 m118 m112 e221 e211"
foreach l of global L{
	gen lic_`l'=0
}

replace lic_e121=1 if ay_eco121==1 & ayud_economia==1
replace lic_e201=1 if ay_eco201==1 & ayud_economia==1
replace lic_m108=1 if ay_mat108==1 & ayud_economia==1
replace lic_m118=1 if ay_mat118==1 & ayud_economia==1
replace lic_m112=1 if ay_mat112==1 & ayud_economia==1
replace lic_e221=1 if ay_eco221==1 & ayud_economia==1
replace lic_e211=1 if ay_eco211==1 & ayud_economia==1

* genero variables de si tuvo ayudante mujer por AREA *
gen 	ayud_eco=0
label 	variable ayud_eco "tuvo ayudante mujer en el area economica"
replace ayud_eco=1 if ay_eco121==1 | ay_eco201==1
gen 	ayud_mat=0
label 	variable ayud_mat "tuvo ayudante mujer en el area matematica"
replace ayud_mat=1 if ay_mat108==1 | ay_mat112==1 | ay_mat118==1

/* genero dummy de si tuvo ayudante mujer de la licenciatura en economia
por AREA */
gen 	lic_eco=0
replace lic_eco=1 if lic_e121==1 | lic_e201==1 | lic_e221==1
gen 	lic_mat=0
replace lic_mat=1 if lic_m108==1 | lic_m118==1 | lic_m112==1

** genero dummies de ayudante corrector/instructor
gen 	tipo_ayudante=.
replace tipo_ayudante=1 if clasificacion_ayudante=="INSTRUCTOR"
replace tipo_ayudante=2 if clasificacion_ayudante=="CORRECTOR"
drop 	clasificacion_ayudante

label 	define tipoayud 1 "INSTRUCTOR" 2 "CORRECTOR"
label 	values tipo_ayudante tipoayud
label 	variable tipo_ayudante "instructor o corrector

********************** INFORMACION SOBRE PROFESORES ***************************
destring id_profesor, replace
*merge m:m id_profesor using "${pathD}DATOS/grados.dta"

rename 	id_profesor id_prof
label 	variable id_prof "identificador de profesor"



/** defino de una manera mas comoda el genero profesor. 
1 sera MUJER y 2 sera HOMBRE **/
gen 		gen_prof=.
replace 	gen_prof=1 		if genero_profesor=="F"
replace 	gen_prof=2 		if genero_profesor=="M"
label 		variable gen_prof "género profesor"
label 		define 			gen 1 "F" 2 "M"
label 		value gen_prof 	gen
drop 		genero_profesor

* dummy de profe mujer
gen			profe_mujer=.
replace 	profe_mujer=1 if gen_prof==1
replace 	profe_mujer=0 if gen_prof==2

/** genero dummy de PROFESOR PLANTA
0 sera profesor con jornada HORA */
rename 	jornada jornada1
gen 	jornada=.
replace jornada=1 if jornada1=="PLANTA"
replace jornada=2 if jornada1=="HORA"
label 	define jornadapr 1 "PLANTA" 2 "HORA"
label 	values jornada jornadapr
label 	variable jornada "Tipo de jornada del profesor"
drop 	jornada1

* dummmy de si el profesor es planta 
gen 	planta=0
replace planta=1 if jornada==1
gen 	pl_e121=0 
replace pl_e121=1 if planta==1 & sigla=="ECO121"
gen 	pl_e201=0
replace pl_e201=1 if planta==1 & sigla=="ECO201"
gen 	pl_e221=0
replace pl_e221=1 if planta==1 & sigla=="ECO221"
gen 	pl_e211=0
replace pl_e211=1 if planta==1 & sigla=="ECO211"
gen 	pl_m108=0
replace pl_m108=1 if planta==1 & sigla=="MAT108"
gen 	pl_m118=0
replace pl_m118=1 if planta==1 & sigla=="MAT118"
gen 	pl_m112=0
replace pl_m112=1 if planta==1 & sigla=="MAT112"
gen 	pl_eco=0
replace pl_eco=1 if pl_e221==1 | pl_e211==1
gen 	pl_mat=0
replace pl_mat=1 if pl_m108==1 | pl_m118==1 | pl_m112==1


* genero dummies de genero (mujer) de profesor en cada ramo *  
gen prof_e121=0
replace prof_e121=1 if gen_prof==1 & sigla=="ECO121"
gen prof_e201=0
replace prof_e201=1 if gen_prof==1 & sigla=="ECO201"
gen prof_m108=0
replace prof_m108=1 if gen_prof==1 & sigla=="MAT108"
gen prof_m118=0
replace prof_m118=1 if gen_prof==1 & sigla=="MAT118"
gen prof_m112=0
replace prof_m112=1 if gen_prof==1 & sigla=="MAT112"
gen prof_e221=0
replace prof_e221=1 if gen_prof==1 & sigla=="ECO221"
gen prof_e211=0
replace prof_e211=1 if gen_prof==1 & sigla=="ECO211"
gen prof_m101=0
replace prof_m101=1 if gen_prof==1 & sigla=="MGT101"
gen prof_m130=0
replace prof_m130=1 if gen_prof==1 & sigla=="MGT130"
gen prof_a111=0
replace prof_a111=1 if gen_prof==1 & sigla=="ACCT111"
gen prof_eco=0
replace prof_eco=1 if prof_e221==1 | prof_e211==1
gen prof_mat=0
replace prof_mat=1 if prof_m108==1 | prof_m118==1 | prof_m112==1

*** genero variable de grado del profesor 
*gen grado=.
*replace grado=1 if grado_titulo=="ESPECIALIDAD MÉDICA"
*replace grado=2 if grado_titulo=="TÉCNICO NIVEL SUPERIOR"
*replace grado=3 if grado_titulo=="LICENCIATURA"
*replace grado=4 if grado_titulo=="TÍTULO PROFESIONAL"
*replace grado=5 if grado_titulo=="MAGÍSTER"
*replace grado=6 if grado_titulo=="DOCTOR"
*
** variable de si profesor tiene PhD
*gen phd=0
*replace phd=1 if grado_titulo=="DOCTOR"
*
*/** genero variables del grado del profesor por asignatura
*g significa grado. eNUM o mNUM son abreviaciones de las siglas 
*de las asignaturas*/ 
*
*gen g_e121=.
*replace g_e121=1 if grado==1 & eco121==1
*replace g_e121=2 if grado==2 & eco121==1
*replace g_e121=3 if grado==3 & eco121==1
*replace g_e121=4 if grado==4 & eco121==1
*replace g_e121=5 if grado==5 & eco121==1
*replace g_e121=6 if grado==6 & eco121==1
*
*gen g_e201=.
*replace g_e201=1 if grado==1 & eco201==1
*replace g_e201=2 if grado==2 & eco201==1
*replace g_e201=3 if grado==3 & eco201==1
*replace g_e201=4 if grado==4 & eco201==1
*replace g_e201=5 if grado==5 & eco201==1
*replace g_e201=6 if grado==6 & eco201==1
*
*gen g_m108=.
*replace g_m108=1 if grado==1 & mat108==1
*replace g_m108=2 if grado==2 & mat108==1
*replace g_m108=3 if grado==3 & mat108==1
*replace g_m108=4 if grado==4 & mat108==1
*replace g_m108=5 if grado==5 & mat108==1
*replace g_m108=6 if grado==6 & mat108==1
*
*gen g_m118=.
*replace g_m118=1 if grado==1 & mat118==1
*replace g_m118=2 if grado==2 & mat118==1
*replace g_m118=3 if grado==3 & mat118==1
*replace g_m118=4 if grado==4 & mat118==1
*replace g_m118=5 if grado==5 & mat118==1
*replace g_m118=6 if grado==6 & mat118==1
*
*gen g_m112=.
*replace g_m112=1 if grado==1 & mat112==1
*replace g_m112=2 if grado==2 & mat112==1
*replace g_m112=3 if grado==3 & mat112==1
*replace g_m112=4 if grado==4 & mat112==1
*replace g_m112=5 if grado==5 & mat112==1
*replace g_m112=6 if grado==6 & mat112==1

save "${pathD}cleandata_1", replace

* * * * * * * * * * * * * * *  COLLAPSE * * * * * * * * * * * * * * * 
/* con esta herramienta me quedo con 1 observacion por alumno, con las
dummies que necesito para el analisis */

collapse (max) prof_eco prof_mat pl_eco pl_mat nota_e121 nota_e201 nota_e211 nota_e221 nota_m108 nota_m112 nota_m118 pl_e121 pl_e201 pl_e211 pl_e221 pl_m108 pl_m112 pl_m118 rend_eco121 rend_eco201 rend_mat108 rend_mat118 rend_mat112 mujer codigo_sede prom_prer eco121 eco201 mat108 mat118 mat112 cohorte adm_especial psu_mat psu_lenguaje puntaje_ranking particular subvencionado municipal ayud_eco ayud_mat lic_eco lic_mat ay_eco121 ay_mat108 ay_mat112 ay_mat118 ay_eco201 ay_eco221 ayh_eco121 ayh_mat108 ayh_mat112 ayh_mat118 ayh_eco201 ayh_eco221 prof_e121 prof_e201 prof_m108 prof_m118 prof_m112 ecomate prom_eco prom_mat prom_otra lic_e121 lic_e201 lic_m108 lic_m118 lic_m112 (sum) Qay_eco121 Qay_mat108 Qay_mat112 Qay_mat118 Qay_eco201 Qayh_eco121 Qayh_mat108 Qayh_mat112 Qayh_mat118 Qayh_eco201 Qayud_eco Qayud_mat Qayudh_eco Qayudh_mat reprobaciones rep_eco rep_mat rep_otra (mean) rend_eco rend_mat nota, by(id_alumno)

** ahora boto las observaciones de viña
/* para mi analisis definitivamente voy  a dejar fuera a todos los alumos de viña
(19,567 observations deleted) */
drop if codigo_sede==2
** aquí me quedo son con los alumnos que cumplen cocn los prerequisitos 
keep if eco121==1 & eco201==1 & mat108==1 & mat118==1 & mat112==1 

save "${pathD}cleandata_2.dta", replace








































