import requests
import time

openAIKey = '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'

openAIHeaders = {
    'Authorization': 'Bearer '+ openAIKey
}

questionsResponse = requests.get('https://the-trivia-api.com/api/questions?limit=15')

if questionsResponse.status_code == 200:
    jsonQuestions = questionsResponse.json() 

newLine = '\n'
file = open('test5.txt', 'w') 

for i in range(1,4):
    file.write(f'Ny hämtning: {newLine}')
    for question in jsonQuestions:
        parsedQuestion = question['question']
        
        openAIData = {
                'model': 'text-davinci-003',
                'prompt': f'Give a hint to the question. DO NOT include the correct answer in the hint. Question: {question} Correct answer: {question["correctAnswer"]}',
                'temperature': 0.6,
                'max_tokens': 50
            }


        start = time.time()
        response = requests.post('https://api.openai.com/v1/completions', headers= openAIHeaders, json= openAIData)
        if response.status_code == 200:
            data = response.json()

            hint = data['choices'][0]['text']
            end = time.time()

            performance = end - start


            file.write(f'Fråga: {parsedQuestion} {newLine} Hint: {hint.strip(newLine)} {newLine} Svar: {question["correctAnswer"]} {newLine} Tid att hämta: {performance} {newLine}{newLine}')
        else:
            print(response.status_code)
file.close()