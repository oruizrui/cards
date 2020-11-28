defmodule Cards do
  @moduledoc """
    Provides methods for crating and handling deck cards
  """
  @moduledoc since: "1.0.0"

  @doc """
    Returns a list of strings representing a deck of playing cards
  """
  @spec create_deck :: [<<_::24, _::_*16>>, ...]
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
       "#{value} of #{suit}"
    end
  end

  @spec shuffle(any) :: [any]
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

   @doc """
      Determines whether a deck contains a given card

    ## Examples

      iex> deck = Cards.create_deck
      iex> card = List.first(deck)
      iex> Cards.contains?(deck,card)
      true
    """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

    @doc """
      Devides a deck into a hand and the reminder of the deck.
      The `hand_size` argument indicates how many carts should
      be in the hand.

    ## Examples

      iex> deck = Cards.create_deck
      iex> {hand,_} = Cards.deal(deck, 1)
      iex> hand
    """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @spec load(
          binary
          | maybe_improper_list(
              binary | maybe_improper_list(any, binary | []) | char,
              binary | []
            )
        ) :: any
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, _reason} -> "error"
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
