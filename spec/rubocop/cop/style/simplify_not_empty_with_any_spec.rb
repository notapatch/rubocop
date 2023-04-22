# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Style::SimplifyNotEmptyWithAny, :config do
  it 'registers an offense when using `!a.empty?`' do
    expect_offense(<<~RUBY)
      !array.empty?
      ^^^^^^^^^^^^^ Use `.any?` and remove the negation part.
    RUBY
  end

  it 'does not register an offense when using `.any?` or `.empty?`' do
    expect_no_offenses(<<~RUBY)
      array.any?
      array.empty?
    RUBY
  end

  it 'corrects `!a.empty?`' do
    expect_offense(<<~RUBY)
      !array.empty?
      ^^^^^^^^^^^^^ Use `.any?` and remove the negation part.
    RUBY

    expect_correction(<<~RUBY)
      array.any?
    RUBY
  end
end
