def mocked_client
  unless @client
    @client = instance_double('CodewarsApi::Client')
    class_double('CodewarsApi::Client', new: @client).as_stubbed_const
  end
  @client
end

Before('@stub_attempt_solution') do
  attempt = instance_double('CodewarsApi::AttemptSolution')
  allow(attempt).to receive(:dmid).and_return('4rsdaDf8d')
  allow(mocked_client).to receive(:attempt_solution).with(
    project_id: '562cbb369116fb896c00002a',
    solution_id: '562cbb379116fb896c00002c',
    code: 'solved_kata'
  ).and_return(attempt)
end

def stub_deffered
  deferred = instance_double('CodewarsApi::DeferredResponse')
  yield(deferred)
  allow(mocked_client).to receive(:deferred_response).with(dmid: '4rsdaDf8d').and_return(deferred)
end

Before('@stub_deferred_response') do
  stub_deffered do |deferred|
    allow(deferred).to receive(:success).and_return(true)
    allow(deferred).to receive(:valid).and_return(true)
  end
end

Before('@stub_deferred_response_invalid') do
  stub_deffered do |deferred|
    allow(deferred).to receive(:success).and_return(true)
    allow(deferred).to receive(:valid).and_return(false)
    allow(deferred).to receive(:reason)
      .and_return('-e: Value is not what was expected (Test::Error)')
  end
end

Before('@stub_deferred_response_progress') do
  stub_deffered do |deferred|
    allow(deferred).to receive(:success).and_return(nil)
  end
end

Before('@stub_finalize_solution') do
  finalize = instance_double('CodewarsApi::FinalizeSolution')
  allow(finalize).to receive(:success).and_return(true)
  allow(mocked_client).to receive(:finalize_solution).with(
    project_id: '562cbb369116fb896c00002a',
    solution_id: '562cbb379116fb896c00002c'
  ).and_return(finalize)
end

def stub_train_next_kata
  train = instance_double('CodewarsApi::TrainNextKata')
  yield(train)
  allow(mocked_client).to receive(:train_next_kata).with(
    language: 'java',
    peek: 'true',
    strategy: 'default'
  ).and_return(train)
end

Before('@stub_train_next_kata_peek') do
  stub_train_next_kata do |train|
    allow(train).to receive(:success).and_return(true)
    allow(train).to receive(:name).and_return('Anything to integer')
    allow(train).to receive(:href).and_return('/kata/anything-to-integer')
    allow(train).to receive(:description)
      .and_return('Description: Your task is to program a function which converts')
    allow(train).to receive(:tags).and_return(%w(Fundamentals Integers))
    allow(train).to receive(:rank).and_return(-5)
    allow(train).to receive(:slug).and_return('anything-to-integer')
  end
end

Before('@stub_train_next_kata_peek_unauthorized') do
  stub_train_next_kata do |train|
    allow(train).to receive(:success).and_return(false)
    allow(train).to receive(:reason).and_return('unauthorized')
  end
end

Before('@stub_train_specific_kata') do
  train = instance_double('CodewarsApi::TrainSpecificKata')
  allow(train).to receive(:slug).and_return('anything-to-integer')
  allow(train).to receive(:name).and_return('Anything to integer')
  allow(train).to receive(:author).and_return('Jake Hoffner')
  allow(train).to receive(:rank).and_return(-6)
  allow(train).to receive(:project_id).and_return('523f66fba0de5d94410001cb')
  allow(train).to receive(:solution_id).and_return('53bc968d35fd2feefd000013')
  allow(train).to receive(:tags).and_return(['Fundamentals', 'Integers', 'Data Types', 'Numbers'])
  allow(train).to receive(:description)
    .and_return('Your task is to program a function which converts')
  allow(train).to receive(:code_setup).and_return('public String test(String str) {}')
  allow(train).to receive(:tests_setup).and_return('Test.expect(toInteger("4.55") === 4)')
  allow(mocked_client).to receive(:train_specific_kata).with(
    language: 'java',
    id_or_slug: 'anything-to-integer'
  ).and_return(train)
  allow(mocked_client).to receive(:train_specific_kata).with(
    language: 'ruby',
    id_or_slug: 'anything-to-integer'
  ).and_return(train)
end
