Translations = {
    error = {
        boat_travelling = 'O barco já partiu. Próximo Barco: 1 Minuto.',
        plane_travelling = 'O avião já partiu. Próximo Avião: 1 Minuto.',
        not_enough_cash = 'Você não tem dinheiro suficiente.',
    },
    success = {
        paid = 'Você pagou %{price}$ pela viagem.',
    },
    target = {
        fly_ls = 'Voar para Los Santos',
        fly_perico = 'Voar para Cayo Perico',
        travel_ls = 'Viajar para Los Santos',
        travel_perico = 'Viajar para Cayo Perico',
    },
    blip = {
        fly = 'Voar para o Perico',
        travel_ls = 'Viajar para LS',
        travel_perico = 'Viajar para o Perico',
    }
} 
Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})