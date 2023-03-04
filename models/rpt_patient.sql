
/*
Models are transformed output.
*/

{{ config(materialized='table') }}

with source_data as (
    select 
        concat(p.firstname, p.lastname) as "name",
        pi.value as "identifier"
    from 
        {{ source('fhir', 'rte_patient') }} p
        inner join {{ source('fhir', 'rte_patient_identifiers')}} pi on p.id = pi.patient_id 
    where
        pi.system = 'http://somesystem.com'
)

select * from source_data
