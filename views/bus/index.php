<?php
/** @var yii\web\View $this */
use yii\helpers\Html;
use yii\widgets\ActiveForm;

$this->title = 'Поиск автобусов';
?>

<h1><?= Html::encode($this->title) ?></h1>

<div class="bus-search">
  

    <?php $form = ActiveForm::begin(['id' => 'bus-search-form']); ?>

    <?= $form->field($model, 'from')->textInput(['placeholder' => 'Введите остановку отправления']) ?>
    <?= $form->field($model, 'to')->textInput(['placeholder' => 'Введите остановку назначения']) ?>

    <div class="form-group">
        <?= Html::submitButton('Найти', ['class' => 'btn btn-primary']) ?>
    </div>

    <?php ActiveForm::end(); ?>
</div>

<div id="results"></div>

<script>
    document.getElementById('bus-search-form').onsubmit = function(event) {
        event.preventDefault();

        const from = document.querySelector('[name="BusSearch[from]"]').value;
        const to = document.querySelector('[name="BusSearch[to]"]').value;

        // Формируем URL для запроса
        const url = '<?= yii\helpers\Url::to(['api/find-bus']) ?>?from=' + encodeURIComponent(from) + '&to=' + encodeURIComponent(to);

        fetch(url)
            .then(response => response.json())
            .then(data => {
                let resultsDiv = document.getElementById('results');
                resultsDiv.innerHTML = '';

                if (data.buses && data.buses.length > 0) {
                    data.buses.forEach(bus => {
                        resultsDiv.innerHTML += `<h3>${bus.route}</h3>`;
                        resultsDiv.innerHTML += `<p>Следующие отправления: ${bus.next_arrivals.join(', ')}</p>`;
                    });
                } else {
                    resultsDiv.innerHTML = '<p>Автобусы не найдены.</p>';
                }
            })
            .catch(error => console.error('Ошибка:', error));
    };
</script>

