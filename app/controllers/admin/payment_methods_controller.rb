# encoding: UTF-8

module Admin
  class PaymentMethodsController < Admin::AdminController
    def index
    end

    def new
    end

    def create
      if payment_method.save
        redirect_to admin_payment_methods_url, :notice => "Typ platby #{payment_method.name} byl vytvořen"
      else
        flash.now[:error] = "Chyba při vytváření typu platby"
        render "new"
      end
    end

    def edit
    end

    def update
      if payment_method.update_attributes(params[:payment_method])
        redirect_to admin_payment_methods_url,
                    notice: "Typ platby #{payment_method.name} byl upraven"
      else
        flash.now[:error] = "Chyba při ukládání typu platby"
        render "edit"
      end
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Nelze najít daný typ platby"
      redirect_to admin_payment_methods_url
    end

    def destroy
      payment_method.destroy
      flash[:notice] = "Typ platby #{payment_method.name} byl smazán"
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Nelze najít daný typ platby"
    ensure
      redirect_to admin_payment_methods_url
    end

    private

    def payment_method
      @payment_method ||= params[:id] ? PaymentMethod.find(params[:id]) : PaymentMethod.new(params[:payment_method])
    end

    helper_method :payment_method

    def payment_methods
      @payment_methods ||= PaymentMethod.all
    end

    helper_method :payment_methods
  end
end