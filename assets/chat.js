document.addEventListener("DOMContentLoaded", function () {
  var chatForm = document.getElementById("chatForm");
  var messageInput = document.getElementById("message");
  var responseDiv = document.getElementById("response");
  var submitBtn = chatForm.querySelector("button[type='submit']");

  chatForm.onsubmit = function (e) {
    e.preventDefault();
    var msg = messageInput.value;

    if (!msg.trim()) {
        alert("Silakan tulis pertanyaan terlebih dahulu.");
        return;
    }
    responseDiv.innerHTML = '<span style="color:gray">Memproses... Mohon tunggu.</span>';
    messageInput.disabled = true;
    if (submitBtn) submitBtn.disabled = true;
    fetch("api_handler.php?text=" + encodeURIComponent(msg))
      .then(response => {
        return response.json();
      })
      .then(data => {
        if (data.status === true && data.result && data.result.text) {
          responseDiv.innerHTML = data.result.text.replace(/\n/g, '<br>');
        } else if (data.error) {
          responseDiv.innerHTML = '<span style="color:red">Terjadi Kesalahan: ' + data.error + '</span>';
        } else {
          responseDiv.innerHTML = '<span style="color:red">Menerima respons dengan format tidak dikenal.</span>';
        }
      })
      .catch(err => {

        responseDiv.innerHTML = '<span style="color:red">Error Kritis: Tidak bisa memproses permintaan. Pastikan file api_handler.php ada dan tidak rusak. (' + err.message + ')</span>';
      })
      .finally(() => {
    
        messageInput.disabled = false;
        if (submitBtn) submitBtn.disabled = false;
        messageInput.value = ""; 
        messageInput.focus();
      });
  };
});