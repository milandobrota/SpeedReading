class SynonymsAndAntonymsTest < ActiveRecord::Base
  belongs_to :user

  class << self
    def setup_for(test_taker)
      new(
        :user => test_taker
      )
    end

    def historical_data_for(user)
      speeds = []
      accuracies = []
      tests = SynonymsAndAntonymsTest.where(:user_id => user.id).order("id asc").select([:speed, :accuracy]).all
      tests.each do |test|
        speeds << test.speed
        accuracies << test.accuracy
      end
      {:speeds => speeds, :accuracies => accuracies}
    end

    def chart_for(user)
      user_data = historical_data_for(user)
      LazyHighCharts::HighChart.new('graph') do |f|
        f.options[:chart][:defaultSeriesType] = 'area'
        f.yAxis([
          {:title => {:text => 'Speed'}},
          {:title => {:text => 'Accuracy'}, :max => 100, :opposite => 'true'}
        ])
        f.xAxis(:title => { :text => 'Test Number'} )
        f.title(:text => 'Synonyms and Antonyms')
        f.series(:name => 'Accuracy', :data => user_data[:accuracies], :yAxis => 0 )
        f.series(:name => 'Speed', :data => user_data[:speeds], :yAxis => 1 )
      end
    end

  end
end
