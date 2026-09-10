# Pass Reception Startup 
library(tidyverse)
library(dplyr)
library(datavolley)
?datavolley
match <- dv_read("Beck_Zimmerman_MSU-IOWA.vsm")
match

stress <- match$plays |> mutate(difference_points)

library(tidyverse)
match_data
match_data <- match$plays
match
all_receptions <- match_data |> filter(skill == "Reception") |>
  mutate(pass_rating = case_match(evaluation_code,
                                  "#" ~ 4,
                                  "+" ~ 3,
                                  "!" ~ 2,
                                  "-" ~ 1,
                                  "/" ~ 0,
                                  "=" ~ 0,
                                  .default = NA
  )) |> select(player_number, player_name, team, skill, skill_subtype, point_won_by, pass_rating)

all_receptions

passer_rating_by_player_num <- all_receptions |> group_by(player_number, player_name, team) |>
  summarize(average_pass_rating = mean(pass_rating))


passer_rating_by_player_num

# Passer Rating of Team 
avg_pass_rtg_by_team <- all_receptions |> group_by(team) |>
  summarize(avg_pass_rating = mean(pass_rating)) |>
  mutate(wl = case_match(team,
                         "Michigan State University" ~ 1,
                         "University of Iowa" ~ 0))

avg_pass_rtg_by_team


# Reading all match data in 
filenames <- c(
  " Beck_Zimmerman_PSU-PITT.vsm", 
  "Anika_Malapati_IND-BRA.vsm", 
  "Anika_Malapati_IOWA-UW.vsm", 
  "Anika_Malapati_NW-NEB.vsm", 
  "Anika_Malapati_OSU-Ohio.vsm", 
  "Anika_Malapati_PSU-MSU.vsm", 
  "Anika_Malapati_PSU-UK.vsm",
  "Anika_Malapati_PU-SMU.vsm",
  "Anika_Malapati_RUT-MSU.vsm",
  "Anika_Malapati_RUT-UMICH.vsm",
  "Anika_Malapati_STA-UT.vsm",
  "Anika_Malapati_UMICH-OSU.vsm",
  "Anika_Malapati_UMN-MSU.vsm",
  "Anika_Malapati_UMN-RU.vsm",
  "Anika_Malapati_UTEP-TAMUCC.vsm",
  "Anika_Malapati_UTEP-UCD.vsm",
  "Anika_Malapati_UW-Madison-UMD.vsm",
  "Anika_Malapati_UW-NW.vsm",
  "Anika_Malapati_UW-PSU.vsm",
  "Anika_Malapati_UW-USC.vsm",
  #"Beck_Zimmerman_BAL-PUR.vsm",
  "Beck_Zimmerman_ILL-PSU.vsm",
  #"Beck_Zimmerman_MEM-TSU.vsm",
  "Beck_Zimmerman_MICH_IOWA.vsm",
  "Beck_Zimmerman_MICH-MSU.vsm",
  "Beck_Zimmerman_MSU-IOWA.vsm",
  "Beck_Zimmerman_MSU-UMD.vsm",
  "Beck_Zimmerman_NU-IU.vsm",
  "Beck_Zimmerman_ORE-UMN.vsm",
  "Beck_Zimmerman_ORE-WISC.vsm",
  "Beck_Zimmerman_OSU-RU.vsm",
  "Beck_Zimmerman_PEP-UCD.vsm",
  #"Beck_Zimmerman_PEP-UTP.vsm",
  #"Beck_Zimmerman_PSU-CMU.vsm",
  "Beck_Zimmerman_PSU-PRIN.vsm",
  "Beck_Zimmerman_STA-UF.vsm",
  "Beck_Zimmerman_STAN-DAVIS.vsm",
  #"Beck_Zimmerman_STAN-USU.vsm",
  "Beck_Zimmerman_TSU-UTEP.vsm",
  "Beck_Zimmerman_UH-PORT.vsm",
  "Beck_Zimmerman_UMD-RU.vsm",
  #"Beck_Zimmerman_UOH-UVU.vsm",
  "Beck_Zimmerman_USC-PURD.vsm",
  "Beck_Zimmerman_UW-MSU.vsm",
  "Beck_Zimmerman_UW-UMN.vsm",
  #"Beck_Zimmerman_WISC-MICH.vsm",
  "Brandon_Wong_STA-ORE.vsm",
  "Ethan_Rome_IU-NU.dvw",
  "Ethan_Rome_NU-UI.dvw",
  "Ethan_Rome_OSU-UF.dvw",
  "Ethan_Rome_OSU-WSU.dvw",
  "Ethan_Rome_OU-UW.dvw",
  "Ethan_Rome_PSU-UW.dvw",
  "Ethan_Rome_PUR-UW.dvw",
  "Ethan_Rome_TCU-PITT.dvw",
  "Ethan_Rome_TSU-ASU.dvw",
  "Ethan_Rome_UIUC-UW.dvw",
  "Ethan_Rome_UMN-UNL.dvw",
  "Ethan_Rome_UNL-STA.dvw",
  "Ethan_Rome_UO-UMICH.dvw",
  "Ethan_Rome_UTEP-UTRGV.dvw",
  "Ethan_Rome_UW-UIUC.dvw",
  "Ethan_Rome_UWM-USC.dvw",
  "Ethan_Rome_WKU-IU.dvw",
  "Ethan_Rome-IU-UW.dvw",
  "Grace_Palumbo_MARY-UIUC.vsm",
  "Grace_Palumbo_MARY-WISC.vsm",
  "Grace_Palumbo_MICH-MIN.vsm",
  "Grace_Palumbo_ORE-IOWA.vsm",
  "Grace_Palumbo_OSU-TROY.vsm",
  "Grace_Palumbo_OSU-USC.vsm",
  "Grace_Palumbo_OSU-UVA.vsm",
  "Grace_Palumbo_PSU-TCU.dvw",
  "Grace_Palumbo_RUT-OSU.vsm",
  "Grace_Palumbo_TSU-TULSA.vsm",
  "Grace_Palumbo_UH-PORT.vsm",
  "Grace_Palumbo_UH-SJU.vsm",
  "Grace_Palumbo_UM-STA.vsm",
  "Grace_Palumbo_UNL-UIUC.vsm",
  "Grace_Palumbo_UO-PSU.vsm",
  "Grace_Palumbo_UW-WISC.vsm",
  "2025-12-04 UCLA-GT.dvw",
  "2025-09-20 UCLA-UH.dvw",
  "2025-09-19 UCLA-TXSU.dvw",
  "2025-10-08 UCLA-MIN.dvw",
  "2025-10-22 UCLA-ORE.dvw",
  "2025-09-02 UCLA-PEPP.dvw",
  "2025-09-11 UCLA-UTEP.dvw",
  "2025-09-28 UCLA-PSU.dvw",
  "2025-09-26 UCLA-OSU.dvw",
  "2025-10-11 UCLA-USC.dvw",
  "2025-11-20 UCLA-ILL.dvw",
  "2025-09-05 UCLA-TCU.dvw",
  "2025-11-28 UCLA-MSU.dvw",
  "2025-10-25 UCLA-MAR.dvw",
  "2025-11-08 UCLA-NU.dvw",
  "2025-10-17 UCLA-WIS.dvw",
  "2025-09-13 UCLA-TSU.dvw",
  "2025-09-21 UCLA-STA.dvw",
  "2025-11-26 UCLA-UM.dvw",
  "2025-09-06 UCLA-TCU.dvw",
  "2025-11-14 UCLA-UNL.dvw",
  "2025-12-05 UCLA-UK.dvw",
  "2025-11-15 UCLA-Rut.dvw",
  "2025-11-02 UCLA-UW.dvw",
  "2025-09-12 UCLA-ORU.dvw",
  "2025-10-02 UCLA-PUR.dvw",
  "2025-09-01 UCLA-CSULB.dvw",
  "2025-11-06 UCLA-ORE.dvw",
  "2025-11-22 UCLA-UW.dvw",
  "2025-10-04 UCLA-IU.dvw"
)


list_of_matches <- lapply(filenames, dv_read)

match_outcomes <- bind_rows(lapply(list_of_matches,
                                   function(x){
                                     x$meta$teams |>
                                       mutate(match_id = x$meta$match_id) |>
                                       dplyr::select(match_id, team, won_match)
                                   }))

all_match_data <- bind_rows(lapply(list_of_matches, function(x) {
  x$plays |>
    mutate(match_id = x$meta$match_id)
}))

all_matches_outcomes <- all_match_data |> left_join(match_outcomes, by = c("match_id", "team"))

write.csv(all_matches_outcomes, "all_matches_outcomes.csv")

# Reception Analysis Function 

all_match_receptions <- all_matches_outcomes |>
  filter(skill == "Reception") |>
  mutate(pass_rating = case_match(evaluation_code,
                                  "#" ~ 4,
                                  "+" ~ 3,
                                  "!" ~ 2,
                                  "-" ~ 1,
                                  "/" ~ 0,
                                  "=" ~ 0,
                                  .default = NA
  ), win_loss = if_else(won_match, 1, 0)) |> 
  dplyr::select(player_number, player_name, team, skill, skill_subtype, point_won_by, pass_rating, win_loss)

all_pass_rtg_by_win <- all_match_receptions |> filter(win_loss == 1) |>
  summarize(avg_pass_rating = mean(pass_rating))

all_pass_rtg_by_loss <- all_match_receptions |> filter(win_loss == 0) |>
  summarize(avg_pass_rating = mean(pass_rating))

avg_pass_rtg_by_team <- all_match_receptions |> group_by(team, win_loss) |>
  summarize(avg_pass_rating = mean(pass_rating))


reception_by_location <- all_match_receptions |> group_by(skill_subtype) |>
  summarize(avg_pass_rating = mean(pass_rating))
reception_by_location

reception_by_player_by_location <- all_match_receptions |> group_by(player_number, player_name, skill_subtype, team) |>
  summarize(avg_pass_rating = mean(pass_rating, na.rm = TRUE), .groups = "drop")
reception_by_player_by_location

rec_low_ranked <- reception_by_player_by_location |> filter(skill_subtype == "Low") |>
  arrange(desc(avg_pass_rating))
rec_low_ranked

find_rec_player_report <- function(x) {
  
  reception_by_player_by_location |> filter(player_name == x) |> 
    dplyr::select(player_name, skill_subtype, avg_pass_rating) |>
    arrange(desc(avg_pass_rating))
  
}

find_rec_player_report("Anna Pringle")

cat("Teams that win matches have an average pass rating of", as.numeric(all_pass_rtg_by_win), ".\n")

cat("Teams that lose matches have an average pass rating of", as.numeric(all_pass_rtg_by_loss), ".\n")

cat("This results in a difference of", as.numeric(all_pass_rtg_by_win) - as.numeric(all_pass_rtg_by_loss), "average passer rating.", "\n")

# Player reception location and by team functions

find_rec_player_report <- function(x) {
  
  reception_by_player_by_location |> filter(player_name == x) |> 
    dplyr::select(player_name, skill_subtype, avg_pass_rating) |>
    arrange(desc(avg_pass_rating))
  
}

find_rec_player_report("Adonia Faumuina")

find_rec_team_report <- function(x) {
  
  reception_by_player_by_location |> filter(team == x) |> 
    dplyr::select(team, player_number, player_name, skill_subtype, avg_pass_rating) |>
    arrange(desc(avg_pass_rating))
  
}

find_rec_team_report("University of Southern California")

all_match_receptions_pass_totals <- all_match_receptions |> 
  group_by(player_name) |> 
  mutate(total_passes = n()) |> 
  filter(total_passes >= 20) |>
  summarize(avg_pass_rating = mean(pass_rating, na.rm = TRUE))

all_match_receptions |> 
  group_by(player_name) |> 
  mutate(total_passes = n()) |>
  filter(team == "University of Southern California")

reception_by_player_by_location
all_match_receptions_pass_totals |> arrange(desc(avg_pass_rating))


reception_by_player_by_location |> filter(skill_subtype == "Overhand") |> arrange(desc(avg_pass_rating))

# Point won or lost by pass rating analysis 
# count of 0 pass rated
pass_0 <- all_match_receptions |> filter(pass_rating == 0)
pass_0 <- nrow(pass_0)

# count of 1 pass rated
pass_1 <- all_match_receptions |> filter(pass_rating == 1)
pass_1 <- nrow(pass_1)

# count of 2 pass rated
pass_2 <- all_match_receptions |> filter(pass_rating == 2)
pass_2 <- nrow(pass_2)

# count of 3 pass rated
pass_3 <- all_match_receptions |> filter(pass_rating == 3)
pass_3 <- nrow(pass_3)

# count of 4 pass rated
pass_4 <- all_match_receptions |> filter(pass_rating == 4)
pass_4 <- nrow(pass_4)

# pass total
pass_total <- nrow(all_match_receptions)

# adding column of 1 or 0 for yes or no the team that passed won the point
pass_rating_point_wol <- all_match_receptions |>
  mutate(won_point = ifelse(point_won_by == team, 1, 0))

# pass rating 0 win loss percentage
pass_rating_point_0_won <- pass_rating_point_wol |>
  filter(pass_rating == 0, won_point == 1)

total_points_won_0 <- nrow(pass_rating_point_0_won)

total_pts_won_per_0 <- total_points_won_0 / pass_0
total_pts_won_per_0

for (i in 0:4) {
  
  pass_i <- all_match_receptions |> filter(pass_rating == i)
  pass_i <- nrow(pass_i)
  
  pass_rating_point_i_won <- pass_rating_point_wol |>
    filter(pass_rating == i, won_point == 1)
  
  total_points_won_i <- nrow(pass_rating_point_i_won)
  total_pts_won_per_i <- round((total_points_won_i / pass_i) * 100, digits = 2)
  
  cat(total_pts_won_per_i, "% chance of winning the point with a ", i, " pass rating", "\n", sep = "")
  
}


# Function to find % of points won by passing rating by team 
Team_Win_Point_Percentage_By_Pass <- function(x) {
  
  pass_rating_point_wol_team <- pass_rating_point_wol |> filter(team == x)
  
  all_match_receptions_team <- all_match_receptions |> filter(team == x)
  
  for (i in 0:4) {
    
    pass_i <- all_match_receptions_team |> filter(pass_rating == i)
    pass_i <- nrow(pass_i)
    
    pass_rating_point_i_won <- pass_rating_point_wol_team |>
      filter(pass_rating == i, won_point == 1)
    
    total_points_won_i <- nrow(pass_rating_point_i_won)
    total_pts_won_per_i <- round((total_points_won_i / pass_i) * 100, digits = 2)
    
    cat(total_pts_won_per_i, "% chance of winning the point with a ", i, " pass rating", "\n", sep = "")
    
  }
  
}

Team_Win_Point_Percentage_By_Pass("Pennsylvania State University")

# New Offensive Statistic
all_attacks <- all_matches_outcomes |> filter(skill == "Attack")

all_attacks_grouped <- all_attacks |> group_by(player_name) |>
  mutate(total_hits = n()) |> 
  ungroup() |> 
  filter(total_hits >= 25) |>
  dplyr::select(team, player_number, player_name, skill_type, evaluation_code, evaluation, attack_code, attack_description, skill_subtype, num_players_numeric, phase, total_hits) |>
  mutate(attack_rating = case_match(evaluation_code,
                                    "#" ~ 3,
                                    "+" ~ 2,
                                    "-" ~ 1,
                                    "/" ~ 0,
                                    "=" ~ 0,
                                    .default = NA
  )) |> dplyr::select(-evaluation_code, -evaluation, -skill_type, -skill_subtype) |>
  mutate(block_rating = case_match(num_players_numeric,
                                   4 ~ 0,
                                   3 ~ 3,
                                   2 ~ 2,
                                   1 ~ 1,
                                   0 ~ 0,
                                   .default = NA
  )) |>
  mutate(rec_tran_phase_diff_score = case_match(phase,
                                                "Reception" ~ 1,
                                                "Transition" ~ 1.5,
                                                .default = NA
  )) |> 
  mutate(diff_score = rec_tran_phase_diff_score * block_rating) |>
  mutate(new_offensive_strength_stat = (attack_rating + 1) / (diff_score + 1))

all_attacks_grouped

kennedy_martin_attacks <- all_attacks_grouped |> filter(player_name == "Kennedy Martin") |>
  drop_na() |>
  mutate(OSS = mean(new_offensive_strength_stat)) |>
  dplyr::select(team, player_number, player_name, total_hits, OSS) |>
  slice(1)

player_attack_score <- function(player) {
  
  player_attacks <- all_attacks_grouped |> filter(player_name == player) |>
    drop_na() |>
    mutate(OSS = mean(new_offensive_strength_stat)) |>
    dplyr::select(team, player_number, player_name, total_hits, OSS) |>
    slice(1)
  return(player_attacks)
  
}

player_attack_score("Kennedy Martin")
player_attack_score("Olivia Babcock")
player_attack_score("Harper Murray")
player_attack_score("Andi Jackson")
player_attack_score("Carter Booth")

players <- c("Kennedy Martin", "Olivia Babcock", "Harper Murray", "Andi Jackson", "Carter Booth", "Emmi Sellman", "Tendai Titley", "Gentry Brown", "Staniszewska Karolina", "Mumcular Bianca")

player_stats <- players |> 
  map_dfr(player_attack_score)

print(player_stats)

all_attacks_OSS <- all_attacks_grouped |> group_by(player_name) |> drop_na() |> 
  mutate(OSS = mean(new_offensive_strength_stat)) |>
  dplyr::select(team, player_number, player_name, total_hits, OSS) |>
  distinct()

all_attacks_OSS

max(all_attacks_OSS$OSS)
min(all_attacks_OSS$OSS)

all_attacks_OSS |> filter(OSS == 3.02)
all_attacks_OSS |> filter(OSS < 1)

# Libero out-of-system efficiency
# removing the double up attacks and combining the set and attacks together into the same line of code
all_match_set_attack <- all_match_data |> filter(skill == "Set" | skill == "Attack") |> filter(team == "Pennsylvania State University") |> filter(!(skill == "Attack" & lag(skill) == "Attack")) |>
  mutate(play_id = cumsum(skill == "Set")) |>
  pivot_wider(
    id_cols = c(video_file_number, play_id, team),
    names_from = skill,
    values_from = -c(video_file_number, play_id, team),
    names_glue = "{skill}_{.value}"
  )

# removing the setter from the calculations
all_match_set_attack_no_setter <- all_match_set_attack |> filter(Set_player_number != 7) |> dplyr::select(Set_player_number, Set_player_name, Attack_player_number, Attack_player_name, Attack_evaluation_code) |>
  mutate(attack_rating = case_match(Attack_evaluation_code,
                                    "#" ~ 1,
                                    "+" ~ 0,
                                    "-" ~ 0,
                                    "/" ~ -1,
                                    "=" ~ -1,
                                    .default = NA
  )) |> drop_na() |>
  group_by(Set_player_number) |>
  mutate(hitter_effiency = sum(attack_rating) / n()) |>
  mutate(number_sets = n()) |>
  ungroup()

# Compiling the table into a summary

setter_hitter_efficiency <- all_match_set_attack_no_setter |>
  group_by(Set_player_number, Set_player_name) |>
  summarize(
    hitter_effiency = sum(attack_rating) / n(),
    number_sets = n(),
    .groups = "drop"
  )

setter_hitter_efficiency

