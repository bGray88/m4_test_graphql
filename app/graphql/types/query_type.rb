module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :items,
    [Types::ItemType],
    null: false,
    description: "Return a list of items"
    def items
      Item.all
    end

    field :items_find,
    [Types::ItemType],
    null: false,
    description: "Return a list of matching items" do
      argument :title, String, required: true
    end
    def items_find(title:)
      Item.where("title ILIKE ?", "%#{title}%")
    end

    field :user,
    Types::UserType,
    null: false,
    description: "Return a matching user" do
      argument :id, ID, required: true
    end
    def user(id:)
      User.find(id)
    end
  end
end
