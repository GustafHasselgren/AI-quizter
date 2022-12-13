import requests
import time
import json

openAIKey = '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'


openAIHeaders = {
    'Authorization': 'Bearer '+ openAIKey
}

newLine = '\n'

file = open('test2.txt', 'w') 

for i in range(1, 10):
    questionsResponse = requests.get('https://the-trivia-api.com/api/questions?limit=5')

    if questionsResponse.status_code == 200:
        jsonQuestions = questionsResponse.json() 

    questions = {}

    for question in jsonQuestions:
        questions[question['id']] = {
            'question': question['question'],
            'correctAnswer': question['correctAnswer']
        }

    #file.write(f'{newLine}Frågorna är: {newLine}{questions}{newLine}')

    openAIData = {
        'model': 'text-davinci-003',
        'prompt': f'Give a hint to each of the questions. Do not give the answer to the question. Format output as json with "id" as key. {questions}',
        'temperature': 0,
        'max_tokens': 800
    }


    #start = time.time()
    response = requests.post('https://api.openai.com/v1/completions', headers= openAIHeaders, json= openAIData)

    jsonResponse = response.json()
    hints = jsonResponse['choices'] 

    if response.status_code != 200:
        print(response.status_code)


    for id in questions:
        stringQuestion = questions[id]['question']
        correctAnswer = questions[id]['correctAnswer']
        textHint = eval(hints[0]['text'])
        questionHint = textHint[id]
        hint = questionHint['hint']
        file.write(f'Frågan är:{newLine} {stringQuestion} {newLine} Svaret är: {newLine} {correctAnswer} {newLine} Hinten är: {newLine} {hint} {newLine}')
    #file.write(f'Hintarna är: {newLine}{hints}{newLine}')
    #end = time.time()

    #performance = end - start
    #file.write(f'{newLine}Att skriva och hämta hintarna tog {performance} sekunder. {newLine}')

file.close()