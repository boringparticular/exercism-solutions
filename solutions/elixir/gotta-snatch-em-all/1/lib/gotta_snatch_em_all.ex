defmodule GottaSnatchEmAll do
  @type card :: String.t()
  @type collection :: MapSet.t(card())

  @spec new_collection(card()) :: collection()
  def new_collection(card) do
    MapSet.new([card])
  end

  @spec add_card(card(), collection()) :: {boolean(), collection()}
  def add_card(card, collection) do
    {MapSet.member?(collection, card), MapSet.put(collection, card)}
  end

  @spec trade_card(card(), card(), collection()) :: {boolean(), collection()}
  def trade_card(your_card, their_card, collection) do
    possible = MapSet.member?(collection, your_card) and not MapSet.member?(collection, their_card)
    new_collection = collection
      |> MapSet.delete(your_card)
      |> MapSet.put(their_card)
      
    {possible, new_collection}
  end

  @spec remove_duplicates([card()]) :: [card()]
  def remove_duplicates(cards) do
    cards
      |> MapSet.new()
      |> MapSet.to_list()
  end

  @spec extra_cards(collection(), collection()) :: non_neg_integer()
  def extra_cards(your_collection, their_collection) do
    your_collection
      |> MapSet.difference(their_collection)
      |> MapSet.to_list()
      |> length()
  end

  @spec boring_cards([collection()]) :: [card()]
  def boring_cards([]), do: []
  def boring_cards([a, b]), do: MapSet.intersection(a, b) |> MapSet.to_list()
  def boring_cards([a, b | rest]), do: boring_cards([MapSet.intersection(a, b) | rest])

  @spec total_cards([collection()]) :: non_neg_integer()
  def total_cards([]), do: 0
  def total_cards([a]), do: a |> MapSet.to_list() |> length()
  def total_cards([a, b]), do: MapSet.union(a, b) |> MapSet.to_list() |> length()
  def total_cards([a, b | rest]), do: total_cards([MapSet.union(a, b) | rest])

  @spec split_shiny_cards(collection()) :: {[card()], [card()]}
  def split_shiny_cards(collection) do
    {shiny, not_shiny} = MapSet.split_with(collection, &String.starts_with?(&1, "Shiny"))
    {MapSet.to_list(shiny), MapSet.to_list(not_shiny)}
  end
end
