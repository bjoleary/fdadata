# Do not hand edit this file. Edit data-raw/reglist.R instead.
#' reglist
#'
#' FDA's Registration and Listing Database download files.
#'
#' Get the latest data using \code{fdadata::etl_reglist()}.
#'
#' @format A list of tibbles.
#'
#' \describe{
#' \item{contact_addresses}{: spec_tbl_df 50,788 × 9 (S3: spec_tbl_df/tbl_df/
#' tbl/data.frame)}
#' \item{address_id}{: chr 1:50788 "367204" "1086430" "1086438" "1086444" ...}
#' \item{contact_id}{: chr 1:50788 "315577" "948632" "948640" "948646" ...}
#' \item{address_line_1}{: chr 1:50788 "8105 NW 74 STREET" "1100 HAWTHORNE LN."
#' "501 BEVILLE RD." "308 PARSONS ST." ...}
#' \item{address_line_2}{: chr 1:50788 NA "PO BOX 34276 ZIP 28234" "--" "P.O.
#' BOX 977" ...}
#' \item{city}{: chr 1:50788 "MIAMI" "CHARLOTTE" "DAYTONA BEACH"
#' "WADESBORO" ...}
#' \item{state_code}{: chr 1:50788 "FL" "NC" "FL" "NC" ...}
#' \item{state_province}{: chr 1:50788 NA NA NA NA ...}
#' \item{iso_country_code}{: chr 1:50788 "US" "US" "US" "US" ...}
#' \item{postal_code}{: chr 1:50788 "33166" "28205" "32119" "28170" ...}
#' ..- attr(*, "spec")=}
#' .. .. cols(}
#' .. .. ADDRESS_ID = 31mcol_character()39m,}
#' .. .. CONTACT_ID = 31mcol_character()39m,}
#' .. .. ADDRESS_LINE1 = 31mcol_character()39m,}
#' .. .. ADDRESS_LINE2 = 31mcol_character()39m,}
#' .. .. CITY = 31mcol_character()39m,}
#' .. .. STATE_CODE = 31mcol_character()39m,}
#' .. .. STATE_PROVINCE = 31mcol_character()39m,}
#' .. .. ISO_COUNTRY_CODE = 31mcol_character()39m,}
#' .. .. POSTAL_CODE = 31mcol_character()39m}
#' .. .. )}
#' ..- attr(*, "problems")=externalptr }
#' \item{estabtypes}{: spec_tbl_df 11 × 3 (S3: spec_tbl_df/tbl_df/tbl/
#' data.frame)}
#' \item{establishment_type_id}{: chr 1:11 "1" "2" "3" "5" ...}
#' \item{establishment_activity}{: chr 1:11 "MANUFACTURE MEDICAL DEVICE FOR
#' ANOTHER PARTY (CONTRACT MANUFACTURER)" "STERILIZE MEDICAL DEVICE FOR ANOTHER
#' PARTY (CONTRACT STERILIZER)" "EXPORT DEVICE TO THE UNITED STATES BUT PERFORM
#' NO OTHER OPERATION ON DEVICE" "MANUFACTURE MEDICAL DEVICE" ...}
#' \item{establishment_type}{: chr 1:11 "CONTRACT MANUFACTURER" "CONTRACT
#' STERILIZER" "FOREIGN EXPORTER" "MANUFACTURER" ...}
#' ..- attr(*, "spec")=}
#' .. .. cols(}
#' .. .. establishment_type_id = 31mcol_character()39m,}
#' .. .. establishment_activity = 31mcol_character()39m,}
#' .. .. establishment_type = 31mcol_character()39m}
#' .. .. )}
#' ..- attr(*, "problems")=externalptr }
#' \item{listing_estabtypes}{: spec_tbl_df 384,836 × 5 (S3: spec_tbl_df/tbl_df/
#' tbl/data.frame)}
#' \item{reg_key}{: chr 1:384836 "5" "5" "5" "5" ...}
#' \item{registration_listing_id}{: chr 1:384836 "10856" "10856" "571486"
#' "571486" ...}
#' \item{establishment_type_id}{: chr 1:384836 "5" "11" "5" "11" ...}
#' \item{establishment_activity}{: chr 1:384836 "MANUFACTURE MEDICAL DEVICE"
#' "COMPLAINT FILE ESTABLISHMENT PER 21 CFR 820.198" "MANUFACTURE MEDICAL
#' DEVICE" "COMPLAINT FILE ESTABLISHMENT PER 21 CFR 820.198" ...}
#' \item{establishment_type}{: chr 1:384836 "MANUFACTURER" "COMPLAINT FILE
#' ESTABLISHMENT" "MANUFACTURER" "COMPLAINT FILE ESTABLISHMENT" ...}
#' ..- attr(*, "spec")=}
#' .. .. cols(}
#' .. .. REG_KEY = 31mcol_character()39m,}
#' .. .. REGISTRATION_LISTING_ID = 31mcol_character()39m,}
#' .. .. ESTABLISHMENT_TYPE_ID = 31mcol_character()39m}
#' .. .. )}
#' ..- attr(*, "problems")=externalptr }
#' \item{listing_pcd}{: spec_tbl_df 293,366 × 5 (S3: spec_tbl_df/tbl_df/tbl/
#' data.frame)}
#' \item{key_val}{: chr 1:293366 "2034845173" "1277128997" "1468634297"
#' "1783591475" ...}
#' \item{product_code}{: chr 1:293366 "FMH" "FYF" "EIC" "GDY" ...}
#' \item{product_code_created_date}{: Date1:293366, format: "1978-01-15"
#' "1994-09-22" ...}
#' \item{owner_operator_number}{: chr 1:293366 "2417536" "2417536" "9028292"
#' "1219313" ...}
#' \item{exempt}{: chr 1:293366 NA NA NA NA ...}
#' ..- attr(*, "spec")=}
#' .. .. cols(}
#' .. .. key_val = 31mcol_character()39m,}
#' .. .. PRODUCT_CODE = 31mcol_character()39m,}
#' .. .. CREATED_DATE = 31mcol_character()39m,}
#' .. .. OWNER_OPERATOR_NUMBER = 31mcol_character()39m,}
#' .. .. EXEMPT = 31mcol_character()39m}
#' .. .. )}
#' ..- attr(*, "problems")=externalptr }
#' \item{listing_proprietary_name}{: spec_tbl_df 559,805 × 3 (S3: spec_tbl_df/
#' tbl_df/tbl/data.frame)}
#' \item{listing_prop_name_id}{: chr 1:559805 "569513" "569514" "494219"
#' "2969338" ...}
#' \item{key_val}{: chr 1:559805 "1641334901" "1150110697" "1639622479"
#' "1334419185" ...}
#' \item{proprietary_name}{: chr 1:559805 "ROYAL IMPERIAL POWDER FREE POLYMER
#' COATED LATEX EXAMINATION GLOVES WITH PROTEIN CONTENT LABELING CLAIM (50
#' MICROGRAMS OR" "ROYAL IMPERIAL NITRILE EXAMINATION GLOVES TEXTURED POWDER-
#' FREE BLUE" "SYMMETRY SURGICAL" "PI CONNECT" ...}
#' ..- attr(*, "spec")=}
#' .. .. cols(}
#' .. .. LISTING_PROP_NAME_ID = 31mcol_character()39m,}
#' .. .. key_val = 31mcol_character()39m,}
#' .. .. PROPRIETARY_NAME = 31mcol_character()39m}
#' .. .. )}
#' ..- attr(*, "problems")=externalptr }
#' \item{manu_id_by_imp}{: spec_tbl_df 153,004 × 4 (S3: spec_tbl_df/tbl_df/tbl/
#' data.frame)}
#' \item{imp_manu_id}{: chr 1:153004 "157615" "157616" "157617" "168308" ...}
#' \item{reg_key}{: chr 1:153004 "207709" "207709" "207709" "219886" ...}
#' \item{manufacturer_reg_key}{: chr 1:153004 "16" "16" "16" "16" ...}
#' \item{key_val}{: chr 1:153004 "1997862402" "1976915075" "1050015389"
#' "1797873423" ...}
#' ..- attr(*, "spec")=}
#' .. .. cols(}
#' .. .. IMP_MANU_ID = 31mcol_character()39m,}
#' .. .. REG_KEY = 31mcol_character()39m,}
#' .. .. MANUFACTURER_REG_KEY = 31mcol_character()39m,}
#' .. .. KEY_VAL = 31mcol_character()39m}
#' .. .. )}
#' ..- attr(*, "problems")=externalptr }
#' \item{official_correspondent}{: spec_tbl_df 33,632 × 7 (S3: spec_tbl_df/
#' tbl_df/tbl/data.frame)}
#' \item{reg_key}{: chr 1:33632 "5" "6" "16" "17" ...}
#' \item{contact_id}{: chr 1:33632 "56959016" "56959016" "3395481"
#' "3395481" ...}
#' \item{first_name}{: chr 1:33632 "SHAWN" "SHAWN" "LINDA" "LINDA" ...}
#' \item{middle_initial}{: chr 1:33632 "P" "P" NA NA ...}
#' \item{last_name}{: chr 1:33632 "FITZGERALD" "FITZGERALD" "RUEDY"
#' "RUEDY" ...}
#' \item{subaccount_company_name}{: chr 1:33632 NA NA NA NA ...}
#' \item{phone_number}{: chr 1:33632 "1-704-4054043-X" "1-704-4054043-X"
#' "1-408-2733423-X" "1-408-2733423-X" ...}
#' ..- attr(*, "spec")=}
#' .. .. cols(}
#' .. .. REG_KEY = 31mcol_character()39m,}
#' .. .. CONTACT_ID = 31mcol_character()39m,}
#' .. .. FIRST_NAME = 31mcol_character()39m,}
#' .. .. MIDDLE_INITIAL = 31mcol_character()39m,}
#' .. .. LAST_NAME = 31mcol_character()39m,}
#' .. .. SUBACCOUNT_COMPANY_NAME = 31mcol_character()39m,}
#' .. .. PHONE_NUMBER = 31mcol_character()39m}
#' .. .. )}
#' ..- attr(*, "problems")=externalptr }
#' \item{owner_operator}{: spec_tbl_df 33,636 × 4 (S3: spec_tbl_df/tbl_df/tbl/
#' data.frame)}
#' \item{reg_key}{: chr 1:33636 "5" "6" "16" "17" ...}
#' \item{contact_id}{: chr 1:33636 "948632" "948632" "3395481" "3395481" ...}
#' \item{firm_name}{: chr 1:33636 "BARNHARDT MFG. CO." "BARNHARDT MFG. CO."
#' "CORDIS CORPORATION" "CORDIS CORPORATION" ...}
#' \item{owner_operator_number}{: chr 1:33636 "1010842" "1010842" "1016427"
#' "1016427" ...}
#' ..- attr(*, "spec")=}
#' .. .. cols(}
#' .. .. REG_KEY = 31mcol_character()39m,}
#' .. .. CONTACT_ID = 31mcol_character()39m,}
#' .. .. FIRM_NAME = 31mcol_character()39m,}
#' .. .. OWNER_OPERATOR_NUMBER = 31mcol_character()39m}
#' .. .. )}
#' ..- attr(*, "problems")=externalptr }
#' \item{reg_imp_id_by_manu}{: spec_tbl_df 207,722 × 3 (S3: spec_tbl_df/tbl_df/
#' tbl/data.frame)}
#' \item{key_val}{: chr 1:207722 "1805410413" "1377667471" "1211805660"
#' "1651424905" ...}
#' \item{importer_reg_key}{: chr 1:207722 "17" "17" "17" "16726" ...}
#' \item{establishment_reg_key}{: chr 1:207722 "16" "16" "16" "16" ...}
#' ..- attr(*, "spec")=}
#' .. .. cols(}
#' .. .. KEY_VAL = 31mcol_character()39m,}
#' .. .. IMPORTER_REG_KEY = 31mcol_character()39m,}
#' .. .. ESTABLISHMENT_REG_KEY = 31mcol_character()39m}
#' .. .. )}
#' ..- attr(*, "problems")=externalptr }
#' \item{registration}{: spec_tbl_df 51,718 × 17 (S3: spec_tbl_df/tbl_df/tbl/
#' data.frame)}
#' \item{reg_key}{: chr 1:51718 "7974" "6047" "6805" "7576" ...}
#' \item{registration_number}{: chr 1:51718 "2649733" "9617472" "2381321"
#' "9681851" ...}
#' \item{fei_number}{: chr 1:51718 "2649733" "3005737891" "2381321"
#' "3002807009" ...}
#' \item{reg_status_id}{: chr 1:51718 "1" "1" "1" "1" ...}
#' \item{initial_importer_flag}{: Factor w/ 2 levels "Yes","No": 1 2 1 2 2 2 2
#' 2 2 2 ...}
#' \item{reg_expiry_date_year}{: int 1:51718 2021 2021 2022 2021 2021 2021 2021
#' 2021 2021 2021 ...}
#' \item{address_type_id}{: chr 1:51718 "F" "U" "F" "U" ...}
#' \item{name}{: chr 1:51718 "PUERTO RICO HOSPITAL SUPPLY, INC." "MARILYN
#' BARRY" "LUV N' CARE, LTD." "COURTNEY CLARK" ...}
#' \item{address_line_1}{: chr 1:51718 "BO CIENAGA BAJA KM 23.9 LOT 10-1" "275
#' AIKEN RD." "3030 AURORA AVE FL 2ND" "221 WEST PHILADELPHIA ST." ...}
#' \item{address_line_2}{: chr 1:51718 "PARQUE INDUSTRIAL GUZMAN" NA NA "SUITE
#' 60W" ...}
#' \item{city}{: chr 1:51718 "ALT RIO GRANDE" "ASHEVILLE" "MONROE" "YORK" ...}
#' \item{state_id}{: chr 1:51718 "PR" "NC" "LA" "PA" ...}
#' \item{iso_country_code}{: chr 1:51718 "US" "US" "US" "US" ...}
#' \item{zip_code}{: chr 1:51718 "00745" "28804" "71201" "17401" ...}
#' \item{postal_code}{: chr 1:51718 NA NA NA NA ...}
#' \item{reg_status}{: Factor w/ 2 levels "Active","Active; Awaiting assignment
#' of registration number": 1 1 1 1 1 1 1 1 1 1 ...}
#' \item{address_type}{: Factor w/ 2 levels "Facility","US Agent": 1 2 1 2 2 1
#' 2 2 1 1 ...}
#' ..- attr(*, "spec")=}
#' .. .. cols(}
#' .. .. REG_KEY = 31mcol_character()39m,}
#' .. .. REGISTRATION_NUMBER = 31mcol_character()39m,}
#' .. .. FEI_NUMBER = 31mcol_character()39m,}
#' .. .. REG_STATUS_ID = 31mcol_character()39m,}
#' .. .. INITIAL_IMPORTER_FLAG = 31mcol_character()39m,}
#' .. .. REG_EXPIRY_DATE_YEAR = 32mcol_integer()39m,}
#' .. .. ADDRESS_TYPE_ID = 31mcol_character()39m,}
#' .. .. NAME = 31mcol_character()39m,}
#' .. .. ADDRESS_LINE_1 = 31mcol_character()39m,}
#' .. .. ADDRESS_LINE_2 = 31mcol_character()39m,}
#' .. .. CITY = 31mcol_character()39m,}
#' .. .. STATE_ID = 31mcol_character()39m,}
#' .. .. ISO_COUNTRY_CODE = 31mcol_character()39m,}
#' .. .. ZIP_CODE = 31mcol_character()39m,}
#' .. .. POSTAL_CODE = 31mcol_character()39m}
#' .. .. )}
#' ..- attr(*, "problems")=externalptr }
#' \item{registration_listing}{: spec_tbl_df 309,298 × 4 (S3: spec_tbl_df/
#' tbl_df/tbl/data.frame)}
#' \item{registration_listing_id}{: chr 1:309298 "1" "2" "3" "4" ...}
#' \item{reg_key}{: chr 1:309298 "17" "16" "16" "16" ...}
#' \item{key_val}{: chr 1:309298 "2055480620" "1962391027" "1920427520"
#' "1676980042" ...}
#' \item{premarket_submission_number}{: chr 1:309298 "K062531" "K001843"
#' "K012993" "K980823" ...}
#' ..- attr(*, "spec")=}
#' .. .. cols(}
#' .. .. REGISTRATION_LISTING_ID = 31mcol_character()39m,}
#' .. .. REG_KEY = 31mcol_character()39m,}
#' .. .. KEY_VAL = 31mcol_character()39m,}
#' .. .. PREMARKET_SUBMISSION_NUMBER = 31mcol_character()39m}
#' .. .. )}
#' ..- attr(*, "problems")=externalptr }
#' \item{us_agent}{: spec_tbl_df 18,086 × 9 (S3: spec_tbl_df/tbl_df/tbl/
#' data.frame)}
#' \item{reg_key}{: chr 1:18086 "8964" "9037" "6594" "8970" ...}
#' \item{name}{: chr 1:18086 "SHANNON MCMURREY" "WAYNE MATELSKI" "INA HAIRSTON"
#' "SHANNON MCMURREY" ...}
#' \item{business_name}{: chr 1:18086 "ESSILOR OF AMERICA INC" NA "DRG
#' INTERNATIONAL, INC." "ESSILOR OF AMERICA INC" ...}
#' \item{bus_phone_area_code}{: chr 1:18086 "214" "202" "973" "214" ...}
#' \item{bus_phone_num}{: chr 1:18086 "4964928" "8576340" "5647555"
#' "4964928" ...}
#' \item{bus_phone_extn}{: chr 1:18086 NA NA "229" NA ...}
#' \item{fax_area_code}{: chr 1:18086 NA NA "973" NA ...}
#' \item{fax_num}{: chr 1:18086 NA NA "5647556" NA ...}
#' \item{email_address}{: chr 1:18086 "SMCMURREY@ESSILORUSA.COM"
#' "WAYNE.MATELSKI@ARENTFOX.COM" "QA@DRG-INTERNATIONAL.COM"
#' "SMCMURREY@ESSILORUSA.COM" ...}
#' ..- attr(*, "spec")=}
#' .. .. cols(}
#' .. .. REG_KEY = 31mcol_character()39m,}
#' .. .. NAME = 31mcol_character()39m,}
#' .. .. BUSINESS_NAME = 31mcol_character()39m,}
#' .. .. BUS_PHONE_AREA_CODE = 31mcol_character()39m,}
#' .. .. BUS_PHONE_NUM = 31mcol_character()39m,}
#' .. .. BUS_PHONE_EXTN = 31mcol_character()39m,}
#' .. .. FAX_AREA_CODE = 31mcol_character()39m,}
#' .. .. FAX_NUM = 31mcol_character()39m,}
#' .. .. EMAIL_ADDRESS = 31mcol_character()39m}
#' .. .. )}
#' ..- attr(*, "problems")=externalptr }
#' }
#'
#' @source [FDA R&L Download Files]()
#' accessed 2021-10-20.
"reglist"
