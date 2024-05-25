const express = require('express');
const pool = require('../server'); // Import the MySQL connection pool
const session = require('express-session'); //for managing logged-in users during sessions
const router = express.Router();

// Define routes
router.get('/food_group', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM food_group');
        res.render('food_group', { rows });
    } catch (error) {
        console.error('Error fetching food_group:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/theme', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM theme');
        res.render('theme', { rows });
    } catch (error) {
        console.error('Error fetching theme:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/cousine', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM cousine');
        res.render('cousine', { rows });
    } catch (error) {
        console.error('Error fetching cousine:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/tag', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM tag');
        res.render('tag', { rows });
    } catch (error) {
        console.error('Error fetching tag:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/ingredient', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM ingredient');
        res.render('ingredient', { rows });
    } catch (error) {
        console.error('Error fetching ingredient:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/recipe', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM recipe');
        res.render('recipe', { rows });
    } catch (error) {
        console.error('Error fetching recipe:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/recipe_has_ingredient', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM recipe_has_ingredient');
        res.render('recipe_has_ingredient', { rows });
    } catch (error) {
        console.error('Error fetching recipe_has_ingredient:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/recipe_has_tag', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM recipe_has_tag');
        res.render('recipe_has_tag', { rows });
    } catch (error) {
        console.error('Error fetching recipe_has_tag:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/cooking_equipment', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM cooking_equipment');
        res.render('cooking_equipment', { rows });
    } catch (error) {
        console.error('Error fetching cooking_equipment:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/recipe_has_cooking_equipment', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM recipe_has_cooking_equipment');
        res.render('recipe_has_cooking_equipment', { rows });
    } catch (error) {
        console.error('Error fetching recipe_has_cooking_equipment:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/tips', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM tips');
        res.render('tips', { rows });
    } catch (error) {
        console.error('Error fetching tips:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/steps', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM steps');
        res.render('steps', { rows });
    } catch (error) {
        console.error('Error fetching steps:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/chef', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM chef');
        res.render('chef', { rows });
    } catch (error) {
        console.error('Error fetching chef:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/specializes_in', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM specializes_in');
        res.render('specializes_in', { rows });
    } catch (error) {
        console.error('Error fetching specializes_in:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/episode', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM episode');
        res.render('episode', { rows });
    } catch (error) {
        console.error('Error fetching episode:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/judge_in_episode', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM judge_in_episode');
        res.render('judge_in_episode', { rows });
    } catch (error) {
        console.error('Error fetching judge_in_episode:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/scores', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM scores');
        res.render('scores', { rows });
    } catch (error) {
        console.error('Error fetching scores:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/cook_has_recipe', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM cook_has_recipe');
        res.render('cook_has_recipe', { rows });
    } catch (error) {
        console.error('Error fetching cook_has_recipe:', error);
        res.status(500).send('Internal Server Error');
    }
});

// Define routes for each query
router.get('/query1', async (req, res) => {
    try {
        const [rows] = await pool.query(`
            SELECT chef_id, cousine_name, AVG(total_score) AS average_score
            FROM (
                SELECT chef_id, cousine_name, (score_1 + score_2 + score_3) AS total_score
                FROM scores
            ) AS score_totals
            GROUP BY chef_id, cousine_name
        `);
        res.json(rows);
    } catch (error) {
        console.error('Error executing query 1:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/query2', async (req, res) => {
    try {
        const [rows] = await pool.query(`
            (SELECT DISTINCT specializes_in.cousine_name AS cousine, chefs_that_took_part.chef_id AS chef_id, chefs_that_took_part.season_number AS season, 'yes' AS took_part
             FROM specializes_in
             JOIN (
                 (SELECT chef_id, episode_number, season_number FROM judge_in_episode)
                 UNION
                 (SELECT chef_id, episode_number, season_number FROM scores)
             ) AS chefs_that_took_part
             ON specializes_in.chef_id = chefs_that_took_part.chef_id
            )
            UNION
            (SELECT DISTINCT cousine, chef_id, season, 'no' AS took_part
             FROM (
                 SELECT DISTINCT specializes_in.cousine_name AS cousine, specializes_in.chef_id AS chef_id, all_the_seasons.season_number AS season
                 FROM specializes_in, (SELECT DISTINCT season_number FROM episode) AS all_the_seasons
                 WHERE NOT EXISTS (
                     (SELECT specializes_in.cousine_name AS cousine, judge_in_episode.chef_id AS chef_id, judge_in_episode.season_number AS season
                      FROM specializes_in
                      JOIN judge_in_episode ON specializes_in.chef_id = judge_in_episode.chef_id
                     )
                     UNION
                     (SELECT specializes_in.cousine_name AS cousine, scores.chef_id AS chef_id, scores.season_number AS season
                      FROM specializes_in
                      JOIN scores ON specializes_in.chef_id = scores.chef_id
                     )
                 )
             ) AS k
            )
        `);
        res.json(rows);
    } catch (error) {
        console.error('Error executing query 2:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/query3', async (req, res) => {
    try {
        const [rows] = await pool.query(`
            SELECT chef_id, COUNT(*) AS number_of_recipes
            FROM chef NATURAL JOIN cook_has_recipe
            WHERE age < 30
            GROUP BY chef_id
            HAVING number_of_recipes = (
                SELECT MAX(recipe_count)
                FROM (
                    SELECT chef_id, COUNT(*) AS recipe_count
                    FROM chef NATURAL JOIN cook_has_recipe
                    WHERE age < 30
                    GROUP BY chef_id
                ) AS k
            )
        `);
        res.json(rows);
    } catch (error) {
        console.error('Error executing query 3:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/query4', async (req, res) => {
    try {
        const [rows] = await pool.query(`
            SELECT chef_id
            FROM chef
            WHERE chef_id NOT IN (
                SELECT chef_id
                FROM judge_in_episode
            )
        `);
        res.json(rows);
    } catch (error) {
        console.error('Error executing query 4:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/query5', async (req, res) => {
    try {
        const [rows] = await pool.query(`
            SELECT j1.chef_id AS judge_1,
                   j2.chef_id AS judge_2,
                   j1.times_as_judge AS number_of_episodes,
                   j1.season_number AS in_season
            FROM (
                SELECT chef_id, season_number, COUNT(*) AS times_as_judge
                FROM judge_in_episode
                GROUP BY chef_id, season_number
            ) AS j1
            JOIN (
                SELECT chef_id, season_number, COUNT(*) AS times_as_judge
                FROM judge_in_episode
                GROUP BY chef_id, season_number
            ) AS j2
            ON j1.times_as_judge = j2.times_as_judge 
                AND j1.season_number = j2.season_number
                AND j1.chef_id <> j2.chef_id  
            WHERE j1.times_as_judge >= 3
        `);
        res.json(rows);
    } catch (error) {
        console.error('Error executing query 5:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/query7', async (req, res) => {
    try {
        const [rows] = await pool.query(`
            SELECT chef_id, COUNT(*) AS times_in_episode
            FROM (
                (SELECT chef_id FROM judge_in_episode) UNION ALL (SELECT chef_id FROM scores)
            ) AS l
            GROUP BY chef_id
            HAVING times_in_episode + 5 <= (
                SELECT DISTINCT MAX(times_in_episode)
                FROM (
                    SELECT chef_id, COUNT(*) AS times_in_episode
                    FROM (
                        (SELECT chef_id FROM judge_in_episode) UNION ALL (SELECT chef_id FROM scores)
                    ) AS p
                    GROUP BY chef_id
                ) AS k
            )
        `);
        res.json(rows);
    } catch (error) {
        console.error('Error executing query 7:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/query8', async (req, res) => {
    try {
        const [rows] = await pool.query(`
            SELECT scores.season_number, scores.episode_number, COUNT(*) AS amount_of_equipment_used
            FROM scores, recipe, recipe_has_cooking_equipment
            WHERE scores.recipe_id = recipe.recipe_id AND recipe.recipe_id = recipe_has_cooking_equipment.recipe_id
            GROUP BY scores.season_number, scores.episode_number
            HAVING amount_of_equipment_used = (
                SELECT MAX(amount_of_equipment_used)
                FROM (
                    SELECT scores.season_number, scores.episode_number, COUNT(*) AS amount_of_equipment_used
                    FROM scores, recipe, recipe_has_cooking_equipment
                    WHERE scores.recipe_id = recipe.recipe_id AND recipe.recipe_id = recipe_has_cooking_equipment.recipe_id
                    GROUP BY scores.season_number, scores.episode_number
                ) AS k
            )
        `);
        res.json(rows);
    } catch (error) {
        console.error('Error executing query 8:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/query9', async (req, res) => {
    try {
        const [rows] = await pool.query(`
            SELECT scores.season_number, AVG(recipe.carbs_per_serving) AS average_carbs
            FROM scores
            JOIN recipe ON scores.recipe_id = recipe.recipe_id
            GROUP BY scores.season_number
        `);
        res.json(rows);
    } catch (error) {
        console.error('Error executing query 9:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/query10', async (req, res) => {
    try {
        const [rows] = await pool.query(`
            SELECT cousine_b2b_one.cousine AS cousine_one,
                   cousine_b2b_two.cousine AS cousine_two,
                   cousine_b2b_one.season1 AS season_one,
                   cousine_b2b_one.season2 AS season_two,
                   cousine_b2b_one.season1_appearances AS appearances_cousine_one_season_one,
                   cousine_b2b_one.season2_appearances AS appearances_cousine_one_season_two,
                   cousine_b2b_two.season1_appearances AS appearances_cousine_two_season_one,
                   cousine_b2b_two.season2_appearances AS appearances_cousine_two_season_two
            FROM ( 
                SELECT cousine_season_appearances_one.cousine AS cousine,
                       cousine_season_appearances_one.season AS season1,
                       cousine_season_appearances_two.season AS season2,
                       cousine_season_appearances_one.appearances AS season1_appearances,
                       cousine_season_appearances_two.appearances AS season2_appearances
                FROM (
                    SELECT cousine.cousine_name AS cousine, scores.season_number AS season, COUNT(*) AS appearances
                    FROM scores
                    JOIN cousine ON scores.cousine_name = cousine.cousine_name
                    GROUP BY cousine.cousine_name, scores.season_number
                    HAVING appearances >= 3
                ) AS cousine_season_appearances_one 
                JOIN (
                    SELECT cousine.cousine_name AS cousine, scores.season_number AS season, COUNT(*) AS appearances
                    FROM scores
                    JOIN cousine ON scores.cousine_name = cousine.cousine_name
                    GROUP BY cousine.cousine_name, scores.season_number
                    HAVING appearances >= 3
                ) AS cousine_season_appearances_two 
                ON cousine_season_appearances_one.cousine = cousine_season_appearances_two.cousine
                WHERE cousine_season_appearances_one.season + 1 = cousine_season_appearances_two.season
            ) AS cousine_b2b_one
            JOIN (
                SELECT cousine_season_appearances_one.cousine AS cousine,
                       cousine_season_appearances_one.season AS season1,
                       cousine_season_appearances_two.season AS season2,
                       cousine_season_appearances_one.appearances AS season1_appearances,
                       cousine_season_appearances_two.appearances AS season2_appearances
                FROM (
                    SELECT cousine.cousine_name AS cousine, scores.season_number AS season, COUNT(*) AS appearances
                    FROM scores
                    JOIN cousine ON scores.cousine_name = cousine.cousine_name
                    GROUP BY cousine.cousine_name, scores.season_number
                    HAVING appearances >= 3
                ) AS cousine_season_appearances_one 
                JOIN (
                    SELECT cousine.cousine_name AS cousine, scores.season_number AS season, COUNT(*) AS appearances
                    FROM scores
                    JOIN cousine ON scores.cousine_name = cousine.cousine_name
                    GROUP BY cousine.cousine_name, scores.season_number
                    HAVING appearances >= 3
                ) AS cousine_season_appearances_two 
                ON cousine_season_appearances_one.cousine = cousine_season_appearances_two.cousine
                WHERE cousine_season_appearances_one.season + 1 = cousine_season_appearances_two.season
            ) AS cousine_b2b_two 
            ON (cousine_b2b_one.season1 = cousine_b2b_two.season1 AND cousine_b2b_one.season2 = cousine_b2b_two.season2)
            WHERE cousine_b2b_one.season1_appearances + cousine_b2b_one.season2_appearances = cousine_b2b_two.season1_appearances + cousine_b2b_two.season2_appearances
                AND cousine_b2b_one.cousine <> cousine_b2b_two.cousine
        `);
        res.json(rows);
    } catch (error) {
        console.error('Error executing query 10:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/query12', async (req, res) => {
    try {
        const [rows] = await pool.query(`
            SELECT only_seasons.season AS season,
                   seasons_and_episodes.episode AS episode,
                   only_seasons.max_total_difficulty_of_season AS episode_total_difficulty
            FROM (
                SELECT scores.season_number AS season, scores.episode_number AS episode, SUM(recipe.difficulty) AS total_difficulty
                FROM scores
                JOIN recipe ON scores.recipe_id = recipe.recipe_id
                GROUP BY scores.season_number, scores.episode_number
            ) AS seasons_and_episodes
            JOIN (
                SELECT season, MAX(total_difficulty) AS max_total_difficulty_of_season
                FROM (
                    SELECT scores.season_number AS season, scores.episode_number AS episode, SUM(recipe.difficulty) AS total_difficulty
                    FROM scores
                    JOIN recipe ON scores.recipe_id = recipe.recipe_id
                    GROUP BY scores.season_number, scores.episode_number
                ) AS k
                GROUP BY season
            ) AS only_seasons
            ON (seasons_and_episodes.season = only_seasons.season AND seasons_and_episodes.total_difficulty = only_seasons.max_total_difficulty_of_season)
        `);
        res.json(rows);
    } catch (error) {
        console.error('Error executing query 12:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/query13', async (req, res) => {
    try {
        const [rows] = await pool.query(`
            SELECT season_number_common AS season, episode_number_common AS episode, SUM(years_of_work_experience_common) AS total_years_of_experience_in_episode
            FROM (
                (SELECT scores.season_number AS season_number_common, scores.episode_number AS episode_number_common, chef.chef_id AS chef_id_common, chef.years_of_work_experience AS years_of_work_experience_common
                 FROM scores
                 JOIN chef ON scores.chef_id=chef.chef_id
                )
                UNION
                (SELECT judge_in_episode.season_number AS season_number_common, judge_in_episode.episode_number AS episode_number_common, chef.chef_id AS chef_id_common, chef.years_of_work_experience AS years_of_work_experience_common
                 FROM judge_in_episode
                 JOIN chef ON judge_in_episode.chef_id=chef.chef_id
                )
            ) AS d
            GROUP BY season_number_common, episode_number_common
            HAVING total_years_of_experience_in_episode = (
                SELECT MIN(total_years_of_experience)
                FROM (
                    SELECT season_number_common, episode_number_common, SUM(years_of_work_experience_common) AS total_years_of_experience
                    FROM (
                        (SELECT scores.season_number AS season_number_common, scores.episode_number AS episode_number_common, chef.chef_id AS chef_id_common, chef.years_of_work_experience AS years_of_work_experience_common
                         FROM scores
                         JOIN chef ON scores.chef_id=chef.chef_id
                        )
                        UNION
                        (SELECT judge_in_episode.season_number AS season_number_common, judge_in_episode.episode_number AS episode_number_common, chef.chef_id AS chef_id_common, chef.years_of_work_experience AS years_of_work_experience_common
                         FROM judge_in_episode
                         JOIN chef ON judge_in_episode.chef_id=chef.chef_id
                        )
                    ) AS k
                    GROUP BY season_number_common, episode_number_common
                ) AS l
            )
        `);
        res.json(rows);
    } catch (error) {
        console.error('Error executing query 13:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/query14', async (req, res) => {
    try {
        const [rows] = await pool.query(`
            SELECT recipe.theme_name, COUNT(*) AS theme_numbers_found
            FROM scores
            JOIN recipe ON scores.recipe_id=recipe.recipe_id
            GROUP BY recipe.theme_name
            HAVING theme_numbers_found = (
                SELECT MAX(theme_numbers_found)
                FROM (
                    SELECT recipe.theme_name, COUNT(*) AS theme_numbers_found
                    FROM scores
                    JOIN recipe ON scores.recipe_id=recipe.recipe_id
                    GROUP BY recipe.theme_name
                ) AS k
            )
        `);
        res.json(rows);
    } catch (error) {
        console.error('Error executing query 14:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/query15', async (req, res) => {
    try {
        const [rows] = await pool.query(`
            SELECT food_group_id, group_name
            FROM food_group
            WHERE food_group_id NOT IN (
                SELECT ingredient.food_group_id
                FROM scores, recipe, recipe_has_ingredient, ingredient
                WHERE scores.recipe_id = recipe.recipe_id AND recipe.recipe_id = recipe_has_ingredient.recipe_id AND recipe_has_ingredient.ingredient_id = ingredient.ingredient_id
            )
        `);
        res.json(rows);
    } catch (error) {
        console.error('Error executing query 15:', error);
        res.status(500).send('Internal Server Error');
    }
});

module.exports = router;
