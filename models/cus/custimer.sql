{{
    config(
        materialized = 'incremental',
        unique_key = 'id' ,
        incremental_strategy='merge'
        
    )
}}
select id, name ,EVENT_TIME from AIRBNB.RAW.customer
 
{% if is_incremental() %}
  -- Only select new or updated rows since the last run
  WHERE EVENT_TIME > (SELECT MAX(EVENT_TIME) FROM {{ this }})
{% endif %}


