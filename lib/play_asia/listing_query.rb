class PlayAsia::ListingQuery < PlayAsia::Query
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
    compatible: 'c'
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

  COMPATIBILITIES = {
    am3_advance_media_player: 23,
    atari_jaguar: 20,
    blackberry_bold_9900_9930: 201,
    blackberry_torch_2_9810: 203,
    blackberry_torch_9850_9860: 205,
    dreamcast: 9,
    dsi_ll_xl_japanese_only: 116,
    famicom_disk_system: 87,
    famicom_nes: 18,
    gamecube: 2,
    game_boy: 59,
    game_boy_advance: 8,
    game_boy_advance_sp: 39,
    game_boy_color: 14,
    game_boy_micro: 60,
    game_boy_pocket: 84,
    game_gear: 30,
    gp2x: 61,
    gp2x_caanoo: 112,
    gp2x_f_200: 97,
    gp2x_wiz: 99,
    gp32: 10,
    htchd7: 137,
    htc_7_trophy: 139,
    htc_cha_cha_a810e: 147,
    htc_desire_hd_a9191: 120,
    htc_evo4g: 157,
    htc_evo_3d_x515m: 149,
    htc_g2: 141,
    htc_increadible_s_s710e: 143,
    htc_one_s_z520e: 135,
    htc_radar_c110e: 155,
    htc_raider_4g_x710e: 151,
    htc_rhyme_s510b: 153,
    htc_sensation_xe_z715e: 133,
    htc_sensation_z710e: 145,
    ipad: 111,
    ipad_2: 119,
    ipad_3: 127,
    iphone_3g: 98,
    iphone_3gs: 114,
    iphone_4: 115,
    iphone_4s: 124,
    iphone_5: 125,
    ipod_4g_20gb: 67,
    ipod_4g_40gb: 68,
    ipod_5g_30gb: 63,
    ipod_5g_60gb: 64,
    ipod_classic_160gb: 95,
    ipod_classic_80gb: 94,
    ipod_mini_4gb_6gb: 66,
    ipod_nano: 62,
    ipod_nano_2nd_gen: 86,
    ipod_nano_3rd_gen: 96,
    ipod_nano_5th_gen: 109,
    ipod_nano_6g: 131,
    ipod_photo_30gb: 69,
    ipod_photo_60gb: 70,
    ipod_series: 92,
    ipod_shuffle: 65,
    ipod_touch: 123,
    ipod_touch_4g: 129,
    kindle_fire: 237,
    kinect: 113,
    laseractive: 103,
    laseractive_ld_rom: 105,
    laseractive_mega_ld: 104,
    lcd_game: 72,
    macbook_pro_15_inch_retina: 233,
    macintosh: 21,
    mark_iii: 58,
    mega_cd: 25,
    msx: 90,
    neo_geo: 22,
    neo_geo_cd: 29,
    neo_geo_pocket: 82,
    neo_geo_pocket_color: 16,
    nintendo64: 4,
    nintendo64_dd: 88,
    nintendo_3ds: 110,
    nintendo_3ds_ll_xl: 231,
    nintendo_ds: 32,
    nintendo_dsi: 102,
    nintendo_dsi_ll_xl: 108,
    nintendo_ds_lite: 71,
    nintendo_mini_classics: 75,
    nintendo_wii: 73,
    nokia_603: 221,
    nokia_c7: 211,
    nokia_e6_00: 215,
    nokia_e7_00: 213,
    nokia_lumia_710: 207,
    nokia_lumia_800: 209,
    nokia_n9: 219,
    nokia_x7_00: 217,
    panasonic_q: 12,
    pc_and_mac: 117,
    pc_cd_rom: 74,
    pc_engine_arcade_cd_rom: 79,
    pc_engine_cd_rom: 78,
    pc_engine_hucard: 76,
    pc_engine_supergrafx: 83,
    pc_engine_super_cd_rom: 77,
    pc_engine_turbo_grafx_16: 19,
    pc_fx: 34,
    pico: 100,
    pippin: 89,
    playdia: 101,
    playstation2: 1,
    playstation3: 37,
    playstation3_slim: 107,
    playstation: 3,
    playstation_vita: 121,
    pocket_dream_console: 85,
    pokemon_mini: 26,
    samsung_galaxy_a_advance_i9070: 159,
    samsung_galaxy_mini_2_gt_s6500: 229,
    samsung_galaxy_note_gt_n7000: 179,
    samsung_galaxy_r_gt_i9103: 171,
    samsung_galaxy_sii_lte_sgh_i727: 173,
    samsung_galaxy_sl_i9003: 167,
    samsung_galaxy_s_captivate: 177,
    samsung_galaxy_s_gt_i9000: 225,
    samsung_galaxy_s_iii_gt_i9300: 227,
    samsung_galaxy_s_ii_gt_i9100: 169,
    samsung_galaxy_tab: 118,
    samsung_galaxy_w_i8150: 175,
    samsung_google_nexuss: 163,
    samsung_gt_i9220: 181,
    samsung_gt_i9228: 183,
    samsung_sgh_i717: 185,
    samsung_shv_e160k: 223,
    samsung_shv_e160l: 191,
    samsung_shv_e160s: 189,
    samsung_shv_e169k: 187,
    samsung_wave_iii_s8600: 161,
    samsung_wave_ii_s8530: 165,
    sega_mega_drive_sega_genesis: 24,
    sega_saturn: 11,
    sony_ericsson_xperia_arc: 197,
    sony_ericsson_xperia_arc_s: 199,
    sony_ericsson_xperia_neo: 193,
    sony_ericsson_xperia_play: 195,
    sony_psp: 33,
    sony_psp_go: 106,
    sony_psp_slim_and_lite: 93,
    super_32x: 35,
    super_famicom_snes: 7,
    three_d_o: 36,
    tomy_evio: 27,
    virtual_boy: 31,
    wii_u: 122,
    windows_pc: 13,
    wonderswan: 15,
    wonderswan_color: 80,
    wonderswan_crystal: 81,
    x68000: 91,
    xbox360: 38,
    xbox: 6
  }

  ENCODINGS = {
    aac: 31,
    audio_cd: 14,
    blu_ray_region_a: 27,
    blu_ray_region_b: 28,
    blu_ray_region_free: 29,
    dvd_region_1: 6,
    dvd_region_2: 7,
    dvd_region_3: 8,
    dvd_region_4: 9,
    dvd_region_5: 10,
    dvd_region_6: 11,
    dvd_region_free: 5,
    hd_dvd_region_2: 24,
    hd_dvd_region_3: 25,
    hd_dvd_region_free: 26,
    no_region_protection: 13,
    ntsc_j: 2,
    ntsc_uc: 3,
    pal: 4,
    record: 30,
    umd_music_region_2: 17,
    umd_music_region_3: 23,
    umd_music_region_free: 22,
    umd_video_region_1: 20,
    umd_video_region_2: 16,
    umd_video_region_2_6: 21,
    umd_video_region_3: 19,
    umd_video_region_free: 18,
    vcd_region_free: 12,
    vhs_region_free: 15
  }

  VERSIONS = {
    asia: 6,
    european: 5,
    hong_kong: 19,
    japanese: 2,
    korean: 3,
    us: 4
  }
  
  def prepare_opts(opts)
    opts[:query] = :listing
    opts[:mask] = map_array_to_string opts[:mask], MASK if opts[:mask]
    opts[:type] = map_array_to_string opts[:type], TYPES, ',' if opts[:type]
    opts[:genre] = map_array_to_string opts[:genre], GENRES, ',' if opts[:genre]
    opts[:compatible] = map_array_to_string opts[:compatible], COMPATIBILITIES, ',' if opts[:compatible]
    opts[:encoding] = map_array_to_string opts[:encoding], ENCODINGS, ',' if opts[:encoding]
    opts[:version] = map_array_to_string opts[:version], VERSIONS, ',' if opts[:version]

    # map true/false literals to 1/0
    opts.each do |key, value|
      if value == true
        opts[key] = '1'
      elsif value == false
        opts[key] = '0'
      end
    end

    opts
  end

  def map_array_to_string(values, map, join_string = nil)
    if values && values.is_a?(Array)
      return values.flatten.map { |k| map[k] || k }.join join_string
    end
    values
  end
end