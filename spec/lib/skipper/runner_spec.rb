require 'spec_helper'
require 'skipper/runner'
require 'thor/core_ext/hash_with_indifferent_access'

describe Skipper::Runner do

  describe '#run' do
    let(:servers) { double(hosts: ['example.com']) }
    let(:params) { {} }
    let(:options) { Thor::CoreExt::HashWithIndifferentAccess.new(params) }
    let(:cli)     { double(say: nil, execute: nil) }
    let(:command) { 'echo cats' }
    let(:runner)  { Skipper::Runner.new(servers, options, cli) }
    subject { runner }

    before do
      runner.stub(:execute)
    end

    context 'options' do
      before do
        runner.stub(:on).and_yield
        runner.run(command)
      end

      context 'no params' do
        it { should have_received(:on).with(['example.com'], in: :parallel) }
      end

      context 'with --limit' do
        let(:params) { { limit: 5 } }
        it { should have_received(:on).with(['example.com'], in: :groups, limit: 5) }
      end

      context 'with --limit and --wait' do
        let(:params) { { limit: 5, wait: 10 } }
        it { should have_received(:on).with(['example.com'], in: :groups, limit: 5, wait: 10) }
      end

      context 'with --wait' do
        let(:params) { { wait: 10 } }
        it { should have_received(:on).with(['example.com'], in: :sequence, wait: 10) }
      end

      context 'with --run-in' do
        let(:params) { { run_in: 'cats' } }
        it { should have_received(:on).with(['example.com'], in: :cats) }
      end

      context 'with all options' do
        let(:params) { { run_in: 'cats', limit: 5, wait: 10 } }
        it { should have_received(:on).with(['example.com'], in: :cats, limit: 5, wait: 10) }
      end

    end

    context 'when Interrupt is encountered' do
      before do
        runner.stub(:on).and_raise(Interrupt.new)
      end

      it 'does not raise' do
        expect { runner.run(command) }.not_to raise_error
      end
    end

    context 'when a SSH error occurs' do
      before do
        runner.stub(:on).and_raise(SSHKit::Runner::ExecuteError.new(double(backtrace: 'cats')))
        runner.run(command)
      end

      it 'does not raise' do
        expect { runner.run(command) }.not_to raise_error
      end

      it 'should print the error' do
        cli.should have_received(:say).with(instance_of(SSHKit::Runner::ExecuteError), :red)
      end
    end

  end

end
