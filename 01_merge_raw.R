## Magdalena Cortina
## Teaching Assistants as Role Models in Economics
####################
## This script merges the raw data into one data base with information about the students, course registration, teachers and TA.

library(data.table)
library(janitor)
library(purrr)
library(foreign)
library(dplyr)
rm(list = ls())

path      <-getwd()
pathD     <-'/Users/mcortinat/Library/Mobile Documents/com~apple~CloudDocs/Desktop/research/rawdata/uai'
pathR     <- '/Users/mcortinat/Library/Mobile Documents/com~apple~CloudDocs/Desktop/research/women_in_econ/02_data'

# Student data (Data alumnos)
alumnos1  <-readRDS(paste0(pathD,"/DATA_ALUMNOS.rds"))
alumnos1  <- clean_names(alumnos1)

alumnos2  <- readRDS(paste0(pathD,"/estado y tipo postulacion.rds"))
alumnos2  <- clean_names(alumnos2)

alumnos3  <- readRDS(paste0(pathD,"/datos alumnos missing.rds"))
alumnos3  <- clean_names(alumnos3)

alumnos4  <- readRDS(paste0(pathD,"/alumnos.rds"))   # cohorte 2020-2021
alumnos4  <- clean_names(alumnos4)

# Course registration data (inscripciones)
insc1     <- readRDS(paste0(pathD,"/INSCRIPCIONES.rds"))
insc1     <- clean_names(insc1)

insc2     <- readRDS(paste0(pathD,"/INSCRIPCIONES COMERCIAL 2020.rds"))
insc2     <- clean_names(insc2)

insc3     <- readRDS(paste0(pathD,"/INSCRIPCIONES 2019-2 COMERCIAL.rds"))
insc3     <- clean_names(insc3)

insc4     <- readRDS(paste0(pathD,"/inscripciones-1.rds")) ## inscripciones 2020/1-2021-1
insc4     <- clean_names(insc4)

# Teaching Assistants data  (ayudantes)
ayud1     <- readRDS(paste0(pathD,"/AYUDANTES POR SECCION.rds")) 
ayud1     <- clean_names(ayud1)

ayud2     <- readRDS(paste0(pathD,"/AYUDANTES ENVÍO 2.rds"))
ayud2     <- clean_names(ayud2)

ayud3     <- readRDS(paste0(pathD,"/AYUDANTES 2019-2.rds"))
ayud3     <- clean_names(ayud3)

ayud4     <- readRDS(paste0(pathD,"/AYUDANTES ECONOMÍA 2020.rds"))
ayud4     <- clean_names(ayud4)

ayud5     <- readRDS(paste0(pathD,"/AYUDANTES CON EVALUACIÓN.rds"))
ayud5     <- clean_names(ayud5)

ayud6     <- readRDS(paste0(pathD,"/evaluacion ayudantes.rds"))
ayud6     <- clean_names(ayud6)
setnames(ayud6, "ev_ayudante", "nota")

# Teachers data (profesores)
prof1     <- readRDS(paste0(pathD,"/EV DOCENTE.rds"))
prof1     <- clean_names(prof1)

prof2     <- readRDS(paste0(pathD,"/GRADOSPROFESORES.rds"))
prof2     <- clean_names(prof2)

prof3     <- readRDS(paste0(pathD,"/GRADOS PROFESORES 2019-2.RDS"))
prof3     <- clean_names(prof3)

# Transforming everything to data.table
list2env(eapply(.GlobalEnv, function(x) {if(is.data.frame(x)) {setDT(x)} else {x}}), .GlobalEnv)

## Merge student data (alumnos)
    alumnos <- merge(alumnos1,alumnos2, by = "id_alumno")
    setnames(alumnos, "psu_historia", "psu_hist")
    missing_psu <- alumnos3
    rm(alumnos1, alumnos2,alumnos3)
    alumnos4$cohorte <- as.numeric(alumnos4$cohorte)
list <- c("nem","psu_mat","psu_ciencias","psu_lenguaje","psu_historia","puntaje_ponderado","puntaje_ranking","promedio_psu")
for (i in list){
    alumnos4[[i]] <- as.character(alumnos4[[i]])
}
    alumnos <- bind_rows(alumnos, alumnos4)

## Merge course registration data
    insc1 <- insc1[,nombre_asignatura:=NULL]
    insc2 <- insc2[,nota:=NA][,nombre_asignatura:=NULL]
    setnames(insc3, "id_profe", "id_profesor")
    setnames(insc3, "jornada_profesor", "jornada")
    setnames(insc4, "jornada_profesor", "jornada")
    insc3[,grado_profesor:=NULL][,nombre_asignatura:=NULL][,nota:=NA]

    inscripciones <- rbind(insc1,insc2,insc3,insc4, fill=T)
    inscripciones <- inscripciones[,1:10]
    rm(insc1,insc2,insc3,insc4)
    

## Merge TA data (ayudantes)
### ayud5 is the one that contains all of the above.    
### ayud5 es la suma de todas las anteriores. es la final que contiene todo
    ayudantes <- rbind(ayud5,ayud6)
    setnames(ayudantes, "id_curso", "id_sec")
    setnames(ayudantes, "genero", "gen_ayud")
    setnames(ayudantes, "nota", "nota_ayud")
    rm(ayud1,ayud2,ayud3,ayud4,ayud5,ayud6)
    

## Merge teachers data
grados_prof <- rbind(prof2,prof3)
rm(prof2,prof3)
prof1 <- prof1[,.(id_sec,ev_doc,sigla,id_profesor)]
#prof1 <- merge(prof1, grados_prof, by = "id_profesor", allow.cartesian=TRUE)
# por ahora, voy a ignorar el grado profesor

#######
data1 <- merge(alumnos,inscripciones, by = "id_alumno")
data1 <- as.data.frame(data1)
ayudantes <- as.data.frame(ayudantes)
data2 <- merge(data1,ayudantes, by ="id_sec")
data3 <- merge(data2,prof1, by = c("id_sec","sigla","id_profesor"), all=T)

# Final data
write.dta(data3, "/Users/mcortinat/Library/Mobile Documents/com~apple~CloudDocs/Desktop/research/women_in_econ/02_data/base_uai.dta")
write.dta(grados_prof, "/Users/mcortinat/Library/Mobile Documents/com~apple~CloudDocs/Desktop/research/women_in_econ/02_data/grados_prof.dta")
