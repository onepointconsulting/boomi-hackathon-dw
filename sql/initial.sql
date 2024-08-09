INSERT INTO public.tb_language(language_code) VALUES ('en');

-- Initial question
INSERT INTO TB_QUESTION(QUESTION, PREFERRED_QUESTION_ORDER, LANGUAGE_ID)
VALUES('Which area of your data ecosystem are you most concerned about?', 1, 
	(SELECT ID FROM public.tb_language language_code where language_code='en'));


-- Suggestions
INSERT INTO TB_QUESTION_SUGGESTIONS(IMG_SRC, IMG_ALT, TITLE, MAIN_TEXT, QUESTION_ID)
	VALUES('poor_data_quality.png', 'Poor data quality', 'Poor data quality', 'Low-quality data can lead to incorrect insights and poor decision-making.', 
	   (SELECT ID FROM TB_QUESTION WHERE QUESTION = 'Which area of your data ecosystem are you most concerned about?'));
	   
INSERT INTO TB_QUESTION_SUGGESTIONS(IMG_SRC, IMG_ALT, TITLE, MAIN_TEXT, QUESTION_ID)
	VALUES('compliance_risks.png', 'Compliance and security risks', 'Compliance and security risks', 'Mishandling data can lead to legal troubles and reputational damage.', 
	   (SELECT ID FROM TB_QUESTION WHERE QUESTION = 'Which area of your data ecosystem are you most concerned about?'));

INSERT INTO TB_QUESTION_SUGGESTIONS(IMG_SRC, IMG_ALT, TITLE, MAIN_TEXT, QUESTION_ID)
	VALUES('data_silos.png', 'Data silos', 'Data silos', 'Data trapped in departmental silos can be inaccessible to other parts.', 
	   (SELECT ID FROM TB_QUESTION WHERE QUESTION = 'Which area of your data ecosystem are you most concerned about?'));

INSERT INTO TB_QUESTION_SUGGESTIONS(IMG_SRC, IMG_ALT, TITLE, MAIN_TEXT, QUESTION_ID)
	VALUES('lack_of_skilled_personnel.png', 'Lack of skilled personnel', 'Lack of skilled personnel', 'Missing skills in data science, analytics, AI and ML can impede the effective use of data.', 
	   (SELECT ID FROM TB_QUESTION WHERE QUESTION = 'Which area of your data ecosystem are you most concerned about?'));

INSERT INTO TB_QUESTION_SUGGESTIONS(IMG_SRC, IMG_ALT, TITLE, MAIN_TEXT, QUESTION_ID)
	VALUES('data_overload.png', 'Data overload', 'Data overload', '"Data glut" can slow down processes and make it difficult to identify what data is actually useful.', 
	   (SELECT ID FROM TB_QUESTION WHERE QUESTION = 'Which area of your data ecosystem are you most concerned about?'));

INSERT INTO TB_QUESTION_SUGGESTIONS(IMG_SRC, IMG_ALT, TITLE, MAIN_TEXT, QUESTION_ID)
	VALUES('cost_and_complexity.png', 'Cost and complexity', 'Cost and complexity', 'A robust data analytics infrastructure requires significant investment of resources.', 
	   (SELECT ID FROM TB_QUESTION WHERE QUESTION = 'Which area of your data ecosystem are you most concerned about?'));

INSERT INTO TB_QUESTION_SUGGESTIONS(IMG_SRC, IMG_ALT, TITLE, MAIN_TEXT, QUESTION_ID)
	VALUES('inconsistent_data_strategies.png', 'Inconsistent data strategies', 'Inconsistent data strategies', 'Difficult to align with modern concepts like Data Fabric, Mesh and Generative AI.', 
	   (SELECT ID FROM TB_QUESTION WHERE QUESTION = 'Which area of your data ecosystem are you most concerned about?'));

INSERT INTO TB_QUESTION_SUGGESTIONS(IMG_SRC, IMG_ALT, TITLE, MAIN_TEXT, QUESTION_ID)
	VALUES('resistence_to_change.png', 'Resistance to change', 'Resistance to change', 'Employees need to adapt to new ways of operating to make data-driven transformation work.', 
	   (SELECT ID FROM TB_QUESTION WHERE QUESTION = 'Which area of your data ecosystem are you most concerned about?'));
	   
	   
	   
CREATE TABLE public.initial_questions (
  language TEXT PRIMARY KEY,
  question TEXT NOT NULL,
  suggestions JSON
);


CREATE TABLE public.user_sessions(
 session TEXT PRIMARY KEY,
 language TEXT ,
 last_step_number INTEGER not null,
 user_name TEXT,
 email TEXT,
 CONSTRAINT fk_language FOREIGN KEY(language) REFERENCES public.initial_questions(language)
);


CREATE TYPE enum_confidence_level AS ENUM ('low', 'medium', 'high');

CREATE TABLE public.user_questions(
 session TEXT not null,
 step_number INTEGER not null,
 question TEXT not null,
 suggestions JSON not null,
 user_answer TEXT,
 confidence_level public.enum_confidence_level,
 rational TEXT,
 question_clarification TEXT[],
 recommendations TEXT[],
 avoidance TEXT[],
 outcomes TEXT[],
 relationships TEXT[],
 PRIMARY KEY(session,step_number),
 CONSTRAINT fk_session FOREIGN KEY(session) REFERENCES public.user_sessions(session)
);

INSERT INTO public.initial_questions (language,question,suggestions) 
VALUES ('en','Which area of your data ecosystem are you most concerned about?','[
	{
		"title": "Poor data quality",
		"suggestion": "Low-quality data can lead to incorrect insights and poor decision-making.",
		"image": "poor_data_quality.png"
	},
	{
		"title": "Compliance and security risks",
		"suggestion": "Mishandling data can lead to legal troubles and reputational damage.",
		"image": "compliance_risks.png"
	},
	{
		"title": "Data silos",
		"suggestion": "Data trapped in departmental silos can be inaccessible to other parts.",
		"image": "data_silos.png"
	},
	{
		"title": "Lack of skilled personnel",
		"suggestion": "Missing skills in data science, analytics, AI and ML can impede the effective use of data.",
		"image": "lack_of_skilled_personnel.png"
	},
	{
		"title": "Data overload",
		"suggestion": "\"Data glut\" can slow down processes and make it difficult to identify what data is actually useful.",
		"image": "data_overload.png"
	},
	{
		"title": "Cost and complexity",
		"suggestion": "A robust data analytics infrastructure requires significant investment of resources.",
		"image": "cost_and_complexity.png"
	},
	{
		"title": "Inconsistent data strategies",
		"suggestion": "Difficult to align with modern concepts like Data Fabric, Mesh and Generative AI.",
		"image": "inconsistent_data_strategies.png"
	},
	{
		"title": "Resistance to change",
		"suggestion": "Employees need to adapt to new ways of operating to make data-driven transformation work.",
		"image": "resistence_to_change.png"
	}
]');

