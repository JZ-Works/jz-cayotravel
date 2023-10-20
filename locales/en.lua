Translations = {
    error = {
        boat_travelling = 'Boat already travelling. Next Boat: 1 Minute.',
        plane_travelling = 'Plane already travelling. Next Plane: 1 Minute.',
        not_enough_cash = 'You do not have enough cash.',
        not_enough_cash_rental = 'You do not have enough cash to rent a car.',
    },
    success = {
        paid = 'You paid $%{price} for the trip.',
        paid_rental = 'You paid $%{price} for the car rental.',
    },
    target = {
        fly_ls = 'Fly to Los Santos',
        fly_perico = 'Fly to Cayo Perico',
        travel_ls = 'Travel to Los Santos',
        travel_perico = 'Travel to Cayo Perico',
        rental = 'Rent a Car',
    },
    blip = {
        fly = 'Fly Perico',
        travel_ls = 'Travel LS',
        travel_perico = 'Travel Perico',
    }
} 
Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})