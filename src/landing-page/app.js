import Gun from 'gun';

const gun = Gun();

const app = {
  init() {
    this.bindEvents();
  },

  bindEvents() {
    document.getElementById('saveButton').addEventListener('click', this.saveData.bind(this));
    document.getElementById('loadButton').addEventListener('click', this.loadData.bind(this));
  },

  saveData() {
    const key = document.getElementById('keyInput').value;
    const value = document.getElementById('valueInput').value;

    gun.get(key).put({ value }, (ack) => {
      if (ack.err) {
        console.error('Error saving data:', ack.err);
      } else {
        console.log('Data saved successfully');
      }
    });
  },

  loadData() {
    const key = document.getElementById('keyInput').value;

    gun.get(key).once((data) => {
      if (data) {
        document.getElementById('valueInput').value = data.value;
        console.log('Data loaded successfully');
      } else {
        console.error('No data found for key:', key);
      }
    });
  }
};

document.addEventListener('DOMContentLoaded', () => {
  app.init();
});
