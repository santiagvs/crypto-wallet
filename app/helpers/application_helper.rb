module ApplicationHelper
    def locale
        I18n.locale == :en ? "Inglês" : "Português do Brasil"
    end

    def date_br(data_us)
        data_us.strftime("%d/%m/%Y")
    end

    def nome_app
        "CRYPTO WALLET APPS"
    end

    def ambiente_rails
        if Rails.env.development?
            "Desenvolvimento"
        elsif Rails.env.production?
            "Produção"
        else
            "Teste"   
        end
    end
end
