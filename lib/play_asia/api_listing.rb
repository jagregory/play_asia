class PlayAsia::Api
  def listing(opts = {})
    opts = process_friendly_keys opts.merge({ query: :listing })
    response = query opts
    
    raise "Query error: '#{response.error_message}'" if response.error?
    
    response.content.search('item').map do |xml|
      item = {}
      xml.search('*').each do |node|
        item[node.name.to_sym] = node.text
      end
      item
    end
  end
  
  private
  MASK = {
    price: 'p',
    barcodes: 'j',
    manufacturer_codes: 'm',
    sale_info: 's',
    release_date: 'r',
    name: 'n',
    image: 'i',
    url: 'l',
    affiliate_url: 'a',
    genre: 'g',
    version: 'v',
    encoding: 'e',
    compatibility: 'c'
  }

  TYPES = {
    accessory: 2,
    cd: 3,
    groceries: 7,
    apparel: 8,
    electronics: 9,
    movie: 4,
    book: 6,
    game: 1,
    toy: 5
  }

  GENRES = {
    strategy_video_game: 10,
    racing_video_game: 11,
    simulation_video_game: 12,
    tv_series_dvd_vcd: 122,
    enka_dvd_vcd: 123,
    puzzle_video_game: 13,
    music_video_game: 14,
    language_learning_software_video_games: 147,
    slg_video_game: 15,
    documentary_dvd_vcd: 159,
    classics_video_game: 16,
    fantasy_mystery_dvd_vcd: 160,
    musical_dvd_vcd: 161,
    rock_pop_dvd_vcd: 162,
    rap_hip_hop_dvd_vcd: 163,
    western_dvd_vcd: 164,
    oldies_dvd_vcd: 165,
    soul_r_and_b_dvd_vcd: 166,
    family_dvd_vcd: 167,
    opera_dvd_vcd: 168,
    concert_dvd_vcd: 169,
    misc_video_game: 17,
    heavy_metal_dvd_vcd: 170,
    jazz_dvd_vcd: 171,
    classical_dvd_vcd: 172,
    folk_dvd_vcd: 173,
    ballet_dvd_vcd: 178,
    sports_video_dvd_vcd: 179,
    action_video_game: 18,
    gambling_dvd_vcd: 185,
    adventure_video_game: 19,
    augmented_reality_video_game: 192,
    fighting_video_game: 2,
    board_video_game: 20,
    party_video_game: 21,
    comedy_dvd_vcd: 22,
    action_dvd_vcd: 23,
    adult_dvd_vcd: 24,
    crime_dvd_vcd: 25,
    drama_dvd_vcd: 26,
    romance_dvd_vcd: 27,
    martial_arts_dvd_vcd: 28,
    horror_dvd_vcd: 29,
    beat_em_up_video_game: 3,
    thriller_dvd_vcd: 30,
    sci_fi_dvd_vcd: 31,
    gambling_video_game: 32,
    pinball_video_game: 33,
    animation_dvd_vcd: 34,
    ghost_dvd_vcd: 35,
    soundtrack_music_cd: 36,
    j_pop_music_cd: 37,
    cantopop_music_cd: 38,
    j_pop_dvd_vcd: 39,
    shooting_video_game: 4,
    video_game_soundtrack_music_cd: 40,
    video_game_movie_dvd_vcd: 41,
    japanese_movie_dvd_vcd: 42,
    non_japanese_movie_dvd_vcd: 43,
    education_dvd_vcd: 44,
    misc_movie_dvd_vcd: 45,
    karaoke_dvd_vcd: 46,
    k_pop_music_cd: 47,
    electronic_music_cd: 48,
    dance_music_cd: 49,
    gun_shooting_video_game: 5,
    pop_music_cd: 50,
    idol_movie_dvd_vcd: 54,
    enka_music_cd: 55,
    hentai_dvd_vcd: 57,
    platform_video_game: 6,
    rpg_video_game: 7,
    action_adventure_video_game: 8,
    sports_video_game: 9
  }
  
  def process_friendly_keys opts
    if opts[:mask] && opts[:mask].is_a?(Array)
      opts[:mask] = opts[:mask].map { |k| MASK[k] || k }.join
    end

    if opts[:type] && opts[:type].is_a?(Array)
      opts[:type] = opts[:type].map { |k| TYPES[k] || k }.join ','
    end

    if opts[:genre] && opts[:genre].is_a?(Array)
      opts[:genre] = opts[:genre].map { |k| GENRES[k] || k }.join ','
    end

    opts
  end
end