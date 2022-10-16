View(sdc_database[sdc_database$date_terminated != "", ])

View(sdc_database[sdc_database$deal_number %in% relevant_deal_numbers, ])

View(sdc_database[sdc_database$deal_number %in% relevant_deal_numbers & sdc_database$date_terminated != "", ])

top_100_database[]

View(sdc_database[1,4])
