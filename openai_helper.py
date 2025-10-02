import logging
import json
import os
from openai import OpenAI

logger = logging.getLogger(__name__)

# берем модель и ключ из env
OPENAI_MODEL = os.getenv("OPENAI_MODEL", "gpt-5-mini")
OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")

client = OpenAI(api_key=OPENAI_API_KEY)


def send_prompt_to_openai(
    system_content: str,
    user_prompt: str,
    model: str = OPENAI_MODEL,
    max_tokens: int = 2000,
    temperature: float = 0.7,
):
    """
    Send a prompt to the OpenAI Chat Completions endpoint (GPT-5 family).
    Returns the content string or None on error.
    """
    try:
        chat_completion = client.chat.completions.create(
            model=model,
            messages=[
                {"role": "system", "content": system_content},
                {"role": "user", "content": user_prompt},
            ],
            max_output_tokens=max_tokens,  # GPT-5 API параметр
            temperature=temperature,
        )

        if not chat_completion.choices:
            logger.error("No completion choices returned by OpenAI.")
            return None

        response_content = chat_completion.choices[0].message.content.strip()
        logger.debug(f"Raw response from OpenAI: {repr(response_content)}")

        return response_content

    except Exception as e:
        logger.error(f"Error calling OpenAI: {str(e)}")
        return None


def parse_json_response(response_content: str) -> dict:
    """
    Try to parse model output as JSON.
    """
    try:
        cleaned = response_content.replace("```json", "").replace("```", "").strip()
        return json.loads(cleaned)
    except json.JSONDecodeError as e:
        logger.error(f"JSON parse error: {e}")
        return None
