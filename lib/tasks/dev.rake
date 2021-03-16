namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando o BD", "Concluído!") { %x(rails db:drop) }
        
      show_spinner("Criando o BD...") { %x(rails db:create) }
        
      show_spinner("Migrando o BD...") { %x(rails db:migrate) }
      
      %x(rails dev:add_mining_types)

      %x(rails dev:add_coins)

    else
      puts "Você não está em ambiente de desenvolvimento!"
    end
  end

desc "Cadastra as moedas"
task add_coins: :environment do
  show_spinner("Cadastrando moedas...") do
  coins =     [
      {
          description: "Bitcoin",
          acronym: "BTC",
          url_image: "https://imagensemoldes.com.br/wp-content/uploads/2020/09/Imagem-Dinheiro-Bitcoin-PNG.png",
          mining_type: MiningType.find_by(acronym: 'PoW')
      },
      {
          description: "Ethereum",
          acronym: "ETH",
          url_image: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Ethereum_logo_2014.svg/471px-Ethereum_logo_2014.svg.png",
          mining_type: MiningType.all.sample
      },
      {
          description: "Dash",
          acronym: "DASH",
          url_image: "https://www.pinclipart.com/picdir/middle/556-5565319_dash-coin-png-email-contact-clipart.png",
          mining_type: MiningType.all.sample
      },
      {
        description: "Dogecoin",
        acronym: "DOGE",
        url_image: "http://assets.stickpng.com/images/5a521f522f93c7a8d5137fc7.png",
        mining_type: MiningType.all.sample
      }
  ]
  
    coins.each do |coin|
        sleep(1)
        Coin.find_or_create_by!(coin)
    end
  end
end
  
desc "Cadastra os tipos de mineração"
task add_mining_types: :environment do
  show_spinner("Cadastrando tipos de mineração...") do
    mining_types = [
      {description: "Proof of Work", acronym: "PoW"},
      {description: "Proof of Stake", acronym: "PoS"},
      {description: "Proof of Capacity", acronym: "PoC"}
    ]

    mining_types.each do |mining_type|
      sleep(1)
      MiningType.find_or_create_by!(mining_type)
    end
  end
end

    def show_spinner(msg_start, msg_end = "Concluído!")
      spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
      spinner.auto_spin
      yield
      spinner.success("(#{msg_end})")
    end
end
