const API_URL_PREFIX =
//   serverless の API の endpoint を入力
  ''

const taskListElement = document.getElementById('task-list')
const taskTitleInputElement = document.getElementById('task-title-input')
const taskAddButtonElment = document.getElementById('task-add-button')

async function loadTasks() {
  const response = await fetch(API_URL_PREFIX + '/tasks')
  const responseBody = await response.json()

  const tasks = responseBody.tasks

  while (taskListElement.firstChild) {
    taskListElement.removeChild(taskListElement.firstChild)
  }

  tasks.forEach((task) => {
    const liElement = document.createElement('li')
    liElement.innerText = task.title

    taskListElement.appendChild(liElement)
  })
}

async function registerTask() {
  const title = taskTitleInputElement.value

  const requestBody = {
    title: title
  }

  await fetch(API_URL_PREFIX + '/tasks', {
    method: 'POST',
    body: JSON.stringify(requestBody)
  })

  await loadTasks()
}

async function main() {
  taskAddButtonElment.addEventListener('click', registerTask)
  await loadTasks()
}

main()