defmodule Test.Plan do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  actions do
    defaults([:create, :read, :update, :destroy])
  end

  attributes do
    uuid_primary_key(:id)
  end

  aggregates do
    count(:number_of_pending_scheduled_trades, :pending_scheduled_trades)
  end

  relationships do
    has_many(:scheduled_trades, Test.Plan.ScheduledTrade)

    has_many :pending_scheduled_trades, Test.Plan.ScheduledTrade do
      filter(expr(trade.state == :scheduled))
      private?(true)
      writable?(false)
    end
  end

  postgres do
    table("plans")
    repo(Test.Repo)
  end
end

defmodule Test.Plan.ScheduledTrade do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  actions do
    defaults([:create, :read, :update, :destroy])
  end

  attributes do
    uuid_primary_key(:id)
  end

  relationships do
    belongs_to(:plan, Test.Plan)
    belongs_to(:trade, Test.Plan.Trade)
  end

  postgres do
    table("scheduled_trades")
    repo(Test.Repo)
  end
end

defmodule Test.Plan.Trade do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  actions do
    defaults([:create, :read, :update, :destroy])
  end

  attributes do
    uuid_primary_key(:id)
    attribute(:state, :string)
  end

  postgres do
    table("trades")
    repo(Test.Repo)
  end
end

defmodule Test.API do
  use Ash.Api

  resources do
    resource(Test.Plan)
    resource(Test.Plan.ScheduledTrade)
    resource(Test.Plan.Trade)
  end
end

# defmodule TestQuery do
#   def run() do
#     Test.Plans
#     |> Test.API.read!(load: :number_of_pending_scheduled_trades)
#   end
# end
