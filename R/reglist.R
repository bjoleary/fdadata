# Do not hand edit this file. Edit data-raw/reglist.R instead.
#' reglist
#'
#' FDA's Registration and Listing Database download files.
#'
#' Get the latest data using \code{fdadata::etl_reglist()}.
#'
#' @format A tibble with 4070071 rows and 55 fields:
#'
#' \describe{
#' \item{reg_key}{chr "6047", "6047", "6047", "6047", "7576…}
#' \item{registration_number}{chr "9617472", "9617472", "9617472", "961…}
#' \item{fei_number}{chr "3005737891", "3005737891", "30057378…}
#' \item{reg_status_id}{chr "1", "1", "1", "1", "1", "1", "1", "1…}
#' \item{initial_importer_flag}{fct No, No, No, No, No, No, No, No, No, N…}
#' \item{reg_expiry_date_year}{int 2021, 2021, 2021, 2021, 2021, 2021, 2…}
#' \item{address_type_id}{chr "U", "U", "U", "U", "U", "U", "U", "U…}
#' \item{name}{chr "MARILYN BARRY", "MARILYN BARRY", "MA…}
#' \item{address_line_1}{chr "275 AIKEN RD.", "275 AIKEN RD.", "27…}
#' \item{address_line_2}{chr NA, NA, NA, NA, "SUITE 60W", "SUITE 6…}
#' \item{city}{chr "ASHEVILLE", "ASHEVILLE", "ASHEVILLE"…}
#' \item{state_id}{chr "NC", "NC", "NC", "NC", "PA", "PA", "…}
#' \item{iso_country_code}{chr "US", "US", "US", "US", "US", "US", "…}
#' \item{zip_code}{chr "28804", "28804", "28804", "28804", "…}
#' \item{postal_code}{chr NA, NA, NA, NA, NA, NA, NA, NA, NA, N…}
#' \item{reg_status}{fct Active, Active, Active, Active, Activ…}
#' \item{address_type}{fct US Agent, US Agent, US Agent, US Agen…}
#' \item{registration_listing_id}{chr "196908", "196908", "196908", "196908…}
#' \item{key_val}{chr "1457317569", "1457317569", "14573175…}
#' \item{premarket_submission_number}{chr "K023465", "K023465", "K023465",
#' "K02…}
#' \item{contact_id}{chr "2885911", "2885911", "2885911", "288…}
#' \item{firm_name}{chr "THERMO FISHER SCIENTIFIC INC.", "THE…}
#' \item{owner_operator_number}{chr "2182773", "2182773", "2182773", "218…}
#' \item{first_name}{chr NA, NA, NA, NA, "COURTNEY", "COURTNEY…}
#' \item{middle_initial}{chr NA, NA, NA, NA, NA, NA, NA, NA, NA, N…}
#' \item{last_name}{chr NA, NA, NA, NA, "CLARK", "CLARK", "CL…}
#' \item{subaccount_company_name}{chr NA, NA, NA, NA, NA, NA, NA, NA, NA, N…}
#' \item{phone_number}{chr NA, NA, NA, NA, "X-248-8954379-X", "X…}
#' \item{contact_address_id}{chr "2963717", "2963717", "2963717", "296…}
#' \item{contact_address_line_1}{chr "168 THIRD AVENUE", "168 THIRD AVENUE…}
#' \item{contact_address_line_2}{chr "--", "--", "--", "--", "SUITE 60W", …}
#' \item{contact_city}{chr "WALTHAM", "WALTHAM", "WALTHAM", "WAL…}
#' \item{contact_state_code}{chr "MA", "MA", "MA", "MA", "PA", "PA", "…}
#' \item{contact_state_province}{chr NA, NA, NA, NA, NA, NA, NA, NA, NA, N…}
#' \item{contact_iso_country_code}{chr "US", "US", "US", "US", "US", "US", "…}
#' \item{contact_postal_code}{chr "02451", "02451", "02451", "02451", "…}
#' \item{us_agent_name}{chr "MARILYN BARRY", "MARILYN BARRY", "MA…}
#' \item{us_agent_business_name}{chr "THERMO FISHER SCIENTIFIC", "THERMO F…}
#' \item{us_agent_bus_phone_area_code}{chr "828", "828", "828", "828", "717",
#' "7…}
#' \item{us_agent_bus_phone_num}{chr "6584400", "6584400", "6584400", "658…}
#' \item{us_agent_bus_phone_extn}{chr NA, NA, NA, NA, NA, NA, NA, NA, NA, N…}
#' \item{us_agent_fax_area_code}{chr NA, NA, NA, NA, "717", "717", "717", …}
#' \item{us_agent_fax_num}{chr NA, NA, NA, NA, "8494343", "8494343",…}
#' \item{us_agent_email_address}{chr "MARILYN.BARRY@THERMOFISHER.COM", "MA…}
#' \item{imp_manu_id}{chr "21066", "21066", "21066", "21066", N…}
#' \item{importer_reg_key}{chr "6043", "6043", "6043", "6043", NA, N…}
#' \item{establishment_reg_key}{chr "6047", "6047", "6047", "6047", NA, N…}
#' \item{listing_prop_name_id}{chr "569508", "569509", "569510", "569511…}
#' \item{proprietary_name}{chr "THERMO SCIENTIFIC HERACELL 150 INCUB…}
#' \item{product_code}{chr "MQG", "MQG", "MQG", "MQG", "EKD", "N…}
#' \item{product_code_created_date}{date 2008-05-09, 2008-05-09, 2008-05-09, …}
#' \item{exempt}{chr NA, NA, NA, NA, NA, NA, NA, NA, NA, N…}
#' \item{establishment_type_id}{chr "5", "5", "5", "5", "9", "9", "9", "9…}
#' \item{establishment_activity}{chr "MANUFACTURE MEDICAL DEVICE", "MANUFA…}
#' \item{establishment_type}{chr "MANUFACTURER", "MANUFACTURER", "MANU…}
#' }
#'
#' @source [FDA R&L Download Files]()
#' accessed 2021-09-28.
"reglist"
