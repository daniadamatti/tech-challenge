class MarkCartAsAbandonedJob
  include Sidekiq::Job

  def perform(*args)
    # TODO: Chamar o serviço que marca o carrinho como abandonado
  end
end
