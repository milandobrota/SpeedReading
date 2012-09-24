class SynonymsAndAntonymsTest < ActiveRecord::Base
  belongs_to :user

  # random 20
  def word_pairs
    @random_pairs ||= WordPair.limit(20).order('random()')
  end

  class << self
    def setup_for(test_taker)
      new(
        :user => test_taker
      )
    end

    def historical_data_for(user)
      speeds = []
      accuracies = []
      timestamps = []
      tests = SynonymsAndAntonymsTest.where(:user_id => user.id).order("id asc").limit(30).where('created_at > ?', 1.month.ago).select([:speed, :accuracy, :created_at]).all
      tests.each do |test|
        speeds << test.speed
        accuracies << test.accuracy
        timestamps << test.created_at.to_i * 1000
      end
      {:speeds => speeds, :accuracies => accuracies, :timestamps => timestamps}
    end

    def chart_for(user)
      user_data = historical_data_for(user)
      LazyHighCharts::HighChart.new('graph') do |f|
        f.options[:chart][:defaultSeriesType] = 'area'
        f.yAxis([
          {:title => {:text => 'Speed'}},
          {:title => {:text => 'Accuracy'}, :max => 100, :opposite => 'true'}
        ])
        f.xAxis(:title => { :text => 'Test Taken'}, :type => 'datetime', :maxZoom => 1.day * 1000 )
        f.title(:text => 'Synonyms and Antonyms')
        f.series(:name => 'Accuracy', :data => user_data[:timestamps].zip(user_data[:accuracies]), :yAxis => 0 )
        f.series(:name => 'Speed', :data => user_data[:timestamps].zip(user_data[:speeds]), :yAxis => 1 )
      end
    end

  end
end
